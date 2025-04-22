import { router } from "@kit.ArkUI";
import { Product } from "../common/common";
import Constants from "../common/contants";
import NavigationModel from "../common/NavigationModel";
import navigationViewModel, { LINK_DATA } from "../common/NavigationViewModel";
import NavigationViewModel from "../common/NavigationViewModel";
import CommodityItem from '../view/CommodityItem';


@Entry
@Component
struct productList{
  @State products: Array<Product>= LINK_DATA;
  @State currentCommodity: number = 0; // 被选中的左侧商品分类序号
  @State requestSuccess: boolean = false; // 是否加载成功
  private CommodityList: Array<NavigationModel> = NavigationViewModel.getLinkData(); // 左侧商品分类列表
  private CommodityScroller: Scroller = new Scroller(); // 左侧商品类别导航滚动条
  private scroller: Scroller = new Scroller(); // 右侧商品信息导航条
  @State searchResults: Array<Product> = [];

  // 搜索框
  @State filteredGoods: Product[] = [];
  @State changeValue: string = ''
  @State submitValue: string = ''

  controller: SearchController = new SearchController()
  aboutToAppear() {
    // 在加载中
    setTimeout(() => {
      this.requestSuccess=true
    }, Constants.LOADING_DURATION);
  }

  @Builder
  CommodityHeader(CommodityName: string) {
    Row() {
      Text(CommodityName)
        .fontSize($r('app.float.header_font_size'))
        .fontColor($r('app.color.base_font_color'))
        .fontFamily($r('app.string.hei_ti_medium'))
        .fontWeight(Constants.TITLE_FONT_WEIGHT)
    }
    .padding({ left: $r('app.float.item_padding_left') })
    .height($r('app.float.classify_item_height'))
    .width(Constants.FULL_PERCENT)
    .backgroundColor($r('app.color.base_background'))
  }
  CommodityChangeAction(index: number, isCommodity: boolean) {
    if (this.currentCommodity !== index) {
      // 更改商品分类状态
      this.currentCommodity = index;
      if (isCommodity) {
        // 滚动右侧商品滚动条，滚动到选中区域
        this.scroller.scrollToIndex(index);
      } else {
        // 滚动左侧商品导航条，滚动到选中区域
        this.CommodityScroller.scrollToIndex(index);
      }
    }
  }


  build() {
    Column() {
      Row() {
        Search({
          value: this.changeValue,
          placeholder: '',
          controller: this.controller
        })
          .searchButton('搜索')
          .width(350)
          .height(40)
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
            this.submitValue = value
          })
          .onChange((value: string) => {
            this.changeValue = value
            this.searchResults = navigationViewModel.searchGoods(value);

          })
      }.backgroundColor($r('app.color.classify_background'))

      Row() {
        if (this.requestSuccess) {
          if (this.changeValue) {
            List({ scroller: this.scroller }) {
              if (this.searchResults.length > 0) {
                ForEach(this.searchResults, (item: Product) => {
                  ListItem() {
                    ChildItem({ products: item })
                      .margin({ bottom: 10 })
                  }
                }, (item: Product) => item.id.toString())
              } else {
                ListItem() {
                  Text("未找到相关商品")
                    .fontSize(16)
                    .width('100%')
                    .textAlign(TextAlign.Center)
                }
              }
            }
            .width('100%')
            .layoutWeight(1)
          } else {
            List({ scroller: this.CommodityScroller }) {
              // 循环商品分类导航列表
              ForEach(this.CommodityList, (item: NavigationModel, index?: number) => {
                ListItem() {
                  CommodityItem({
                    CommodityName: item.goodsName,
                    isSelected: this.currentCommodity === index,
                    onClickAction: () => {
                      if (index !== undefined) {
                        // 调用切换函数
                        this.CommodityChangeAction(index, true);
                      }
                    }
                  })
                }
              }, (item: NavigationModel) => item.goodsName + this.currentCommodity)
            }
            .height(Constants.FULL_PERCENT)
            .width($r('app.float.classify_item_width'))
            .backgroundColor($r('app.color.classify_background'))
            .scrollBar(BarState.Off)

            List({ scroller: this.scroller }) {
              ForEach(this.CommodityList, (CommodityItem: NavigationModel) => {
                ListItemGroup({
                  header: this.CommodityHeader(CommodityItem.goodsName),
                  space: Constants.GOODS_ITEM_PADDING
                }) {
                  ForEach(CommodityItem.GoodsList, (courseItem: Product) => {
                    ListItem() {
                      ChildItem({ products: courseItem })
                    }
                  }, (courseItem: Product) => `${courseItem.id}`)
                }
              }, (item: NavigationModel) => `${item.commodityId}`)
            }
            .padding({ left: $r('app.float.item_padding_left'), right: $r('app.float.course_item_padding') })
            .sticky(StickyStyle.Header)
            .layoutWeight(1)
            .edgeEffect(EdgeEffect.None)
            .onScrollIndex((start: number) => this.CommodityChangeAction(start, false))
          }
        }
      }
    }
    }
}
@Component
struct ChildItem {
  @Prop products: Product
  build() {
    Row (){ // 外层改用 Row 实现横向布局
      // 放置商品图片
      Image(this.products !== undefined ? this.products?.imageUrl : '')
        .height(50)
        .width(50)
        .aspectRatio(1)
        .margin({ right: 10 })

      Column (){
        Text(this.products.name)
          .fontSize(14)
          .margin({ bottom: 4 })

        Row() {
          Text('单价: ' + String(this.products.price))
            .fontSize(14)
            .margin({ right: 10 })

          Button('购买')
            .fontSize(12)
            .width(60)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/purchase',
                params: this.products
              })
            })
        }
      }
      .width('70%')
    }
    .padding(10)
      .borderRadius(8)
      .backgroundColor(0xFFFFFF)
      .height(80)
      .width('100%')
  }
}
