
// 定义配色主题
#let themes = (
  // 蓝粉主题
  blue-pink: (
    primary: rgb(164, 197, 218), // 主要蓝色
    secondary: rgb(224, 187, 198), // 主要粉色
    accent: rgb(183, 206, 206), // 点缀色
    background: rgb(246, 240, 237), // 背景色
    text: rgb(71, 84, 103), // 文字色
    border: rgb(201, 215, 223), // 边框色
  ),
  // 纯白主题
  white: (
    primary: rgb(157, 178, 191), // 主要色
    secondary: rgb(215, 196, 187), // 次要色
    accent: rgb(190, 198, 196), // 点缀色
    background: rgb(255, 255, 255), // 背景色
    text: rgb(82, 92, 101), // 文字色
    border: rgb(225, 229, 232), // 边框色
  ),
  // 暗黑主题
  dark: (
    primary: rgb(87, 121, 145), // 主要色
    secondary: rgb(147, 112, 123), // 次要色
    accent: rgb(108, 128, 128), // 点缀色
    background: rgb(28, 32, 37), // 背景色
    text: rgb(221, 226, 232), // 文字色
    border: rgb(64, 73, 82), // 边框色
  ),
)

// 定义文档模板
#let book-template(
  title: "未命名",
  author: none,
  theme: "blue-pink",
  body,
) = {
  // 设置当前主题
  let current-theme = themes.at(theme, default: themes.blue-pink)

  // 设置页面基本样式
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    fill: current-theme.background,
  )

  // 设置文本基本样式
  set text(
    font: ("Source Han Serif", "Linux Libertine"),
    size: 11pt,
    fill: current-theme.text,
  )

  // 设置标题样式
  set heading(
    numbering: "第 1 章",
    //
  )

  // 封面
  align(center)[
    #block(
      fill: current-theme.background,
      inset: 2em,
      radius: 5pt,
      [
        #text(size: 2em, weight: "bold", color: current-theme.primary)[#title]

        #v(2em)

        #if author != none [
          #text(size: 1.2em, color: current-theme.secondary)[#author]
        ]
      ],
    )
  ]

  pagebreak()

  // 正文样式设置
  set par(
    justify: true,
    leading: 0.8em,
    first-line-indent: 2em,
  )

  // 章节标题样式
  show heading: it => block[
    #v(2em)
    #box(
      width: 100%,
      inset: (x: 1em, y: 0.5em),
      fill: color.lighten(current-theme.primary, 90%),
      radius: 4pt,
      [
        #text(weight: "bold", color: current-theme.primary, size: 1.5em)[
          #it.body
        ]
      ],
    )
    #v(1em)
  ]

  // 正文内容
  body
}

// 使用示例
#show: book-template.with(
  title: "魔法之约",
  author: "作者名",
  theme: "blue-pink",
)

= 第一卷 星辰之光

== 水晶之心

银色的月光洒落在魔法学院的尖塔上，水晶般的建筑在夜色中散发着柔和的光芒。莉莉安站在高塔的窗前，她的银发在微风中轻轻飘动，手中的魔法水晶散发出淡淡的蓝光。

这是她成为见习魔法师的第一个夜晚，空气中弥漫着古老咒语的芬芳。远处的魔法森林在月光下显得神秘而迷人，不时有彩色的魔法火花在林间闪现。

== 初次咒语

清晨的第一缕阳光穿过彩绘玻璃窗，在教室的地板上投下斑斓的光影。莉莉安握着她的魔法杖，深吸一口气，准备施展她的第一个正式咒语。

魔法导师艾莉娅站在一旁，她祖母绿色的长袍上绣着神秘的符文，正在耐心地指导着这位天赋异禀的新学徒。教室里飘浮着几颗会发光的魔法球，照亮了古老的魔法书架。

// 使用其他主题的示例
#show: book-template.with(
  title: "暗夜传说",
  author: "作者名",
  theme: "dark",
)

= 序章

在这个被永夜笼罩的世界里...
