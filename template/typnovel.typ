#import "utils/toChinese.typ": num_to_chinese, date_to_chinese
#import "utils/convert.typ": to-string
#import "@preview/pinit:0.2.2": *
#let thing(body) = context {
  let size = measure(body)
  size
}
#let chapter(
  title: str,
  chapternum: int,
  volume: str,
  volumenum: int,
  date: datetime,
  doc,
) = {
  // Font and text part
  set text(
    font: "LXGW WenKai",
    size: 12pt,
    cjk-latin-spacing: auto,
    fallback: true,
    hyphenate: true,
  )

  // Par part
  set par(
    linebreaks: "optimized",
  )


  if date == none {
    // Then today
    date = datetime.today()
  }
  if title == none {
    title = "Untitled"
  }
  if chapternum == none {
    chapternum = 1
  }

  // The main part
  // Set the title
  set align(right)
  let num_str = "第" + num_to_chinese(num: chapternum, style:"simp") + "章\n"
  let title_pre = [
    #set text(size: 22pt, weight: "medium")
    #num_str
    #pin(1)#title#pin(2)
    // #pinit-place(1, dx: -200pt, dy: 12pt)[#line(length: 200pt)]
    #pinit-line(stroke: 1.5pt + gray, start-dy: 0.5em, end-dy: 0.5em, 1, 2)
    #set text(size: 8pt, fill: luma(100)) 
    #let wid = context measure()[卷#num_to_chinese(num: volumenum, style:"simp")#box(width: 1em)#volume]
    #wid.fields()
    // #box(width: 6em, height: auto)[
    //   #set text(size: 8pt, fill: luma(100)) 
    //   #set align(right)
    //   卷#num_to_chinese(num: volumenum, style:"simp")#box(width: 1em)#volume
    // ]
  ]
  let title_content = block(title_pre)
  title_content
  box(height: 1cm)
  set align(left)
  doc
}


