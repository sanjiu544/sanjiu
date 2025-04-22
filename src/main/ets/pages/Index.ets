import router from '@ohos.router'

@Entry
@Component
struct Index {

  build() {

    Column() {
      Text('智慧超市系统')
        .fontSize(30)
        .margin({ bottom: 40 })

      Button('进入商店')
        .width(200)
        .height(50)
        .fontSize(18)
        .margin(10)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ProductList'
          })
        })

      Button('会员')
        .width(200)
        .height(50)
        .fontSize(18)
        .margin(10)
        .onClick(() => {
          // 可以添加其他页面的路由
          //console.log('进入电子菜单')
          router.pushUrl({
            url: 'pages/linshi'
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}