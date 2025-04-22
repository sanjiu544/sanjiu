// 假设已正确初始化store和创建数据库表（例如表名为'PRODUCT'）
// 表结构应包含字段：id, name, price, stock, category
import { relationalStore } from '@kit.ArkData';
import { LINK_DATA } from '../common/NavigationViewModel';
import { BusinessError } from '@kit.BasicServicesKit';
import { globalStore } from '../entryability/EntryAbility';
import { Product } from '../common/common';

// 插入数据到数据库的函数
export function insertProducts() {
  LINK_DATA.forEach((product: Product) => {
    // 排除superId和imageUrl，构建ValuesBucket
    const valueBucket: relationalStore.ValuesBucket = {
      ID: product.id,
      NAME: product.name,
      PRICE: product.price,
      STOCK: product.stock,
      CATEGORY: product.category
    };

    if (globalStore) {
      (globalStore as relationalStore.RdbStore).insert(
        'PRODUCT', // 假设表名为PRODUCT，根据实际情况修改
        valueBucket,
        (err: BusinessError, rowId: number) => {
          if (err) {
            console.error(`Failed to insert product ${product.id}. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info(`Succeeded in inserting product ${product.name}. rowId:${rowId}`);
        }
      );
    }
  });
}

// 查询数据的函数
export function queryProducts() {
  let predicates2 = new relationalStore.RdbPredicates('PRODUCT');
  predicates2.equalTo('NAME', '西瓜');
  if (globalStore !== undefined) {
    (globalStore as relationalStore.RdbStore).query(
      predicates2,
      ['ID', 'NAME', 'PRICE', 'STOCK', 'CATEGORY'],
      (err: BusinessError, resultSet) => {
        if (err) {
          console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
        while (resultSet.goToNextRow()) {
          const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
          const name = resultSet.getString(resultSet.getColumnIndex('NAME'));
          const price = resultSet.getLong(resultSet.getColumnIndex('PRICE'));
          const stock = resultSet.getDouble(resultSet.getColumnIndex('STOCK'));
          const category = resultSet.getValue(resultSet.getColumnIndex('CATEGORY'));
          console.info(`id=${id}, name=${name}, price=${price}, stock=${stock}, category=${category}`);
        }
        // 释放数据集的内存
        resultSet.close();
      }
    );
  }
}

// 执行插入和查询操作
insertProducts();
queryProducts();
