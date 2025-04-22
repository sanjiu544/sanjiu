//自动导入先前创建好的三个数据模型
//TODO
import { Product } from "./common";
import NavigationModel from "./NavigationModel";


//TODO
class NavigationViewModel {
  /**   * 获取商品分类列表数据   *
   * 返回 Array<商品分类模型> 商品类别的ID 以及 对应连接的具体商品信息列表
   inkDataList   */

  getLinkData(): Array<NavigationModel> {
    let linkDataList: Array<NavigationModel> = [];
    let superId: number = 0;
    LINK_DATA.forEach((item: Product) => {
      if (superId !== item.superId) {
        // 如果该分类id不存在，则添加此商品分类模型中
        let GoodsItem: NavigationModel = new NavigationModel(item.superId, item.name, []);
        linkDataList.push(GoodsItem);
      }
      // 添加具体商品信息模型
      let GoodsItem: Product = new Product(superId,item.id,item.name, item.price,item.stock,item.category,item.imageUrl);
      linkDataList[linkDataList.length-1].GoodsList.push(GoodsItem);
      superId = item.superId;
    });
    return linkDataList;
  }
  searchGoods(keyword: string): Array<Product> {
    if (!keyword.trim()) return [];
    return LINK_DATA.filter(item =>
    item.name.toLowerCase().includes(keyword.toLowerCase())
    ).map(item =>
    new Product(
      item.superId,
      item.id,
      item.name,
      item.price,
      item.stock,
      item.category,
      item.imageUrl
    )
    );
  }
}

//TODO
let navigationViewModel = new NavigationViewModel();

export default navigationViewModel as NavigationViewModel;


export const LINK_DATA: Product[] = [new Product(1,1, '苹果', 5, 30, '水果', $r('app.media.apple')),
  new Product(1,2, '西瓜', 8, 20, '水果',$r('app.media.xigua')),
  new Product(1,3, '香蕉', 3, 40, '水果',$r('app.media.xiangjiao')),
  new Product(1,4, '草莓', 15, 15, '水果',$r('app.media.caomei')),
  new Product(2,5, '毛巾', 10, 80, '生活用品',$r('app.media.maojing')),
  new Product(2,6, '牙刷', 5, 100, '生活用品',$r('app.media.yashua')),
  new Product(2,7, '香皂', 3, 120, '生活用品',$r('app.media.xiangzao')),
  new Product(3,8, '可乐', 3, 50, '饮料',$r('app.media.kele')),
  new Product(3,9, '橙汁', 4, 60, '饮料',$r('app.media.chengzhi')),
  new Product(3,10, '茶Π', 5, 100, '饮料',$r('app.media.chaipai')),
  new Product(4,11, '白菜', 2, 50, '蔬菜',$r('app.media.baicai')),
  new Product(4,12, '萝卜', 3, 45, '蔬菜',$r('app.media.luobo')),
  new Product(4,13, '西红柿', 4, 38, '蔬菜',$r('app.media.xihongshi')),
  new Product(5,14, '薯片', 2.5, 42, '零食',$r('app.media.shupian')),
  new Product(5,15, '巧克力', 5, 32, '零食',$r('app.media.qiaokeli')),
  new Product(5,16, '坚果', 2, 60, '零食',$r('app.media.jianguo'))]
// 创建所链接数据
