#import "utils/toChinese.typ": num_to_chinese, date_to_chinese
#import "utils/convert.typ": to-string
#import "@preview/pinit:0.2.2": *

// Function to set default values
#let set_defaults(date, title, chapternum) = {
  if date == none {
    date = datetime.today()
  }
  if title == none {
    title = "Untitled"
  }
  if chapternum == none {
    chapternum = 1
  }
  (date, title, chapternum)
}

// Function to generate chapter number string
#let generate_chapter_num_str(chapternum, specialChapterNum) = {
  let num_str = "第" + num_to_chinese(num: chapternum, style: "simp") + "章\n"
  if specialChapterNum != none {
    num_str = specialChapterNum + "\n"
  }
  num_str
}

// Function to prepare title content
#let prepare_title_content(title, chapternum, volume, volumenum, specialChapterNum, specialVolumeNum) = {
  let num_str = generate_chapter_num_str(chapternum, specialChapterNum)
  let title_pre = [
    #set text(size: 22pt, weight: "medium", fill: rgb(54, 54, 54, 230))
    #num_str
    #set text(fill: rgb(44, 62, 80, 255))
    #pin(1)#title#pin(2)
    #pinit-line(stroke: 1.5pt + gray, start-dy: 0.5em, end-dy: 0.5em, 1, 2)
    #set text(size: 8pt, fill: luma(100))
    #let wid = context {
      let vol = "卷" + num_to_chinese(num: volumenum, style: "simp") + "　" + volume
      if specialVolumeNum != none {
        vol = specialVolumeNum + volume
      }
      let cont = [#vol]
      let wd = measure()[#cont].width
      pinit-place(2, dx: -wd, dy: 20pt)[#box(width: wd)[#cont]]
    }
    #wid
  ]
  block(title_pre)
}

// Function to generate date string
#let generate_date_str(date, specialDate, dateAppendix) = {
  let date_str = date_to_chinese(date: date, style: "simp")
  if specialDate != none {
    date_str = specialDate
  }
  date_str = date_str + dateAppendix
  date_str
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
  // Set default values if not provided
  (date, title, chapternum) = set_defaults(date, title, chapternum)

  // Font and text settings
  set text(
    font: "LXGW WenKai",
    size: 12pt,
    cjk-latin-spacing: auto,
    fallback: true,
    hyphenate: true,
    lang: "zh",
  )

  set page(fill: rgb("#f5f5f5"))

  // Paragraph settings
  set par(linebreaks: "optimized")
  set text(hyphenate: auto)

  // Set the title alignment to right
  set align(right)

  // Prepare title content
  let title_content = prepare_title_content(title, chapternum, volume, volumenum, specialChapterNum, specialVolumeNum)

  title_content

  // Add spacing after title
  box(height: 1cm)

  // Set alignment and paragraph settings for document content
  set align(left)
  set par(linebreaks: "optimized", first-line-indent: 2em)
  let fakepar = context {
    let b = par(box())
    b
    v(-measure(b + b).height)
  }
  show math.equation.where(block: true): it => it + fakepar // 公式后缩进
  show heading: it => it + fakepar // 标题后缩进
  show figure: it => it + fakepar // 图表后缩进
  show enum.item: it => it + fakepar
  show list.item: it => it + fakepar
  let noindent() = h(-2em)

  set align(center)
  // Add document content

  (
    box()[
      #set align(left)
      #fakepar#doc
    ]
      + pin(3)
  )


  // Generate date string
  let date_str = generate_date_str(date, specialDate, dateAppendix)

  // Place date string at the bottom
  context {
    let date_size = measure()[#date_str]
    pinit-place(3, dx: -date_size.width, dy: 1cm)[
      #set align(right)
      #set text(weight: "medium")
      #date_str
    ]
  }

  // Add a page break
  pagebreak(weak: true)
}
