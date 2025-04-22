// 自动导入具体商品信息数据模型
//TODO
import { Product } from "./common";

/**
 * 商品分类数据模型
 */
export default class NavigationModel {
  //TODO
  commodityId: number;
  /**   * 商品分类名称   */
  goodsName: string;
  /**   * 单个商品分类下对应的具体商品数组   */
  GoodsList: Array<Product>;

  //TODO
  constructor(commodityId: number, goodsName: string, courseList: Array<Product>) {
    this.commodityId = commodityId;
    this.goodsName = goodsName;
    this.GoodsList = courseList;
  }


}