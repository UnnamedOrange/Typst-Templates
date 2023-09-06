#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let 字体 = (
  仿宋: ("Times New Roman", "FangSong"),
  宋体: ("Times New Roman", "SimSun"),
  黑体: ("Times New Roman", "SimHei"),
  楷体: ("Times New Roman", "KaiTi"),
  代码: ("New Computer Modern Mono", "Times New Roman", "SimSun"),
)

#let article(
  title: "",
  authors: (),
  date: datetime.today(),
  doc
) = {

  // Set the document's metadata.
  set document(title: title, author: authors)

  // Set the document's basic default styles.
  set page(paper: "a4", numbering: "1", number-align: center)
  set text(字号.小四, font: 字体.宋体, lang: "zh")
  set heading(numbering: "1.1 ")
  show heading: it => {
    it
    v(0.5em)
  }

  // Set behavior of Chinese.
  show strong: it => text(font: 字体.黑体, weight: "semibold", it.body)
  show emph: it => text(font: 字体.楷体, style: "italic", it.body)
  show raw: set text(font: 字体.代码)

  // Make title.
  {
    pad(bottom: 1em, {
      set text(字号.小一)
      align(center)[
        #block[*#title*]
      ]
      set text(字号.小二)
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, author)),
      )
      align(center)[
        #block[
          #date.display("[year] 年 [month] 月 [day] 日")
        ]
      ]
    })
  }

  doc
}
