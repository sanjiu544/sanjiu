import { Product } from "../common/common";
import { relationalStore } from "@kit.ArkData";
import { globalStore } from "../entryability/EntryAbility";
import { BusinessError } from "@kit.BasicServicesKit";

@Entry
@Component
export default struct linshi{

  // 定义响应式状态：存储查询结果、加载状态、错误信息
  @State queryResults: Product[] = []; // 查询到的产品列表
  @State isLoading: boolean = false; // 加载状态
  @State queryError: string | null = null; // 错误信息

  ngOnInit() {
    // 页面初始化时触发查询
    this.fetchProductsFromDatabase();
  }

  // 封装查询逻辑（含状态更新）
  private fetchProductsFromDatabase() {
    this.isLoading = true; // 开始加载
    this.queryError = null; // 清除旧错误

    const predicates = new relationalStore.RdbPredicates('PRODUCT');
    predicates.equalTo('NAME', '西瓜'); // 查询条件

    if (globalStore) {
      (globalStore as relationalStore.RdbStore).query(
        predicates,
        ['ID', 'NAME', 'PRICE', 'STOCK', 'CATEGORY'],
        (err: BusinessError, resultSet: relationalStore.ResultSet) => {
          if (err) {
            // 处理错误：更新状态（需在 UI 线程执行，ArkTS 自动处理回调中的状态更新）
            this.queryError = `查询失败：Code ${err.code}, 信息 ${err.message}`;
            this.isLoading = false;
            return;
          }

          // 解析结果集并转换为 Product 数组
          const products: Product[] = [];
          while (resultSet.goToNextRow()) {
            const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
            const name = resultSet.getString(resultSet.getColumnIndex('NAME'));
            const price = resultSet.getLong(resultSet.getColumnIndex('PRICE'));
            const stock = resultSet.getDouble(resultSet.getColumnIndex('STOCK'));
            const category = resultSet.getValue(resultSet.getColumnIndex('CATEGORY')) as string;

            // 假设 Product 类构造函数需要这些参数（根据实际类定义调整）
            products.push(new Product(0, id, name, price, stock, category,$r('app.media.xigua'))); // superId 和 imageUrl 需根据实际填充
          }
          resultSet.close(); // 释放资源

          // 更新响应式状态
          this.queryResults = products;
          this.isLoading = false;
        }
      );
    }
  }

  build() {
    Column({ space: 20 }) {
      // 标题
      Text('查询结果').fontSize(20).fontWeight(500).margin(10);

      // 加载状态提示
      if (this.isLoading) {
        Text('加载中...').fontSize(16).fontColor('#666');
      }

      // 错误提示
      if (this.queryError) {
        Text(this.queryError).fontSize(16).fontColor('#FF0000');
      }

      // 数据列表
      if (this.queryResults.length > 0 && !this.isLoading && !this.queryError) {
        List({ space: 15 }) {
          ForEach(this.queryResults, (product: Product, index: number) => {
            ListItem() {
              Column({ space: 8 }) {
                Text(`名称: ${product.name}`).fontSize(14);
                Text(`价格: ${product.price} 元`).fontSize(12).fontColor('#666');
                Text(`库存: ${product.stock}`).fontSize(12).fontColor('#666');
                Text(`分类: ${product.category}`).fontSize(12).fontColor('#666');
              }
            }
          }, (product: Product) => product.id.toString()); // 提供唯一键（id）
        }
      } else if (!this.isLoading && this.queryResults.length === 0) {
        Text('未找到匹配的产品').fontSize(16).fontColor('#666');
      }
    }.padding(20); // 页面内边距
  }
}