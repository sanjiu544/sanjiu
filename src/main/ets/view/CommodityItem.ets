// 引入先前构建好的常量类别，框架代码中已提供
import Constants from "../common/contants";

@Component
export default struct CommodityItem {
  CommodityName?: string;
  @Prop isSelected: boolean = false;
  // TODO
  onClickAction = () => {}  //函数体可以暂时空着不定义，等到使用CommodityItem组件时再定义

  // TODO


  build() {
    Text(this.CommodityName)
      .fontSize($r('app.float.normal_font_size'))
      .fontColor(this.isSelected ? $r('app.color.base_font_color') : $r('app.color.normal_font_color'))
      .fontFamily(this.isSelected ? $r('app.string.hei_ti_medium') : $r('app.string.hei_ti'))
      .fontWeight(this.isSelected ? Constants.TITLE_FONT_WEIGHT : Constants.LABEL_FONT_WEIGHT)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? $r('app.color.base_background') : '')
      .width(Constants.FULL_PERCENT)
      .height($r('app.float.classify_item_height'))
        // TODO
        //为这个文本定义一个点击事件处理
      .onClick(this.onClickAction)

  }
}