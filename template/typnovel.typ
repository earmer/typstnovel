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
  specialChapterNum: none,
  specialVolumeNum: none,
  specialDate: none,
  dateAppendix: none,
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
  if specialChapterNum != none {
    num_str = specialChapterNum + "\n"
  }
  let title_pre = [
    #set text(size: 22pt, weight: "medium", fill: luma(64))
    #num_str
    #set text(fill: luma(0))
    #pin(1)#title#pin(2)
    // #pinit-place(1, dx: -200pt, dy: 12pt)[#line(length: 200pt)]
    #pinit-line(stroke: 1.5pt + gray, start-dy: 0.5em, end-dy: 0.5em, 1, 2)
    #set text(size: 8pt, fill: luma(100))
    #let wid = context {
      let vol = "卷" + num_to_chinese(num: volumenum, style:"simp") + "　" + volume
      if specialVolumeNum != none {
        vol = specialVolumeNum + volume
      }
      let cont = [#vol]
      let wd = measure()[#cont].width
      pinit-place(2, dx: -wd, dy: 20pt)[#box(width: wd)[#cont]]
    }
    #wid
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
  set par(linebreaks: "optimized", first-line-indent: 2em)
  box()[#doc]+pin(3)
  let date_str = date_to_chinese(date: date, style: "simp")
  if specialDate != none {
    date_str = specialDate
  }
  date_str = date_str + dateAppendix
  context {
    let date_size = measure()[#date_str]
    pinit-place(3, dx: -date_size.width, dy: 1cm)[
      #set align(right)
      #set text(weight: "medium")
      #date_str
    ]
  }
  pagebreak(weak: true)
}