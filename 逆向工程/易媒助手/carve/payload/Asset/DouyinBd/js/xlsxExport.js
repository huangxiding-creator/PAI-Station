/** 纯前端 原生导出excel */

const trans2Base64 = content => {
  return window.btoa(unescape(encodeURIComponent(content)))
}

function exportExcelFromFront(params) {
  const { cellList, headerList, caption, exportName } = params
  const captionEle = caption ? `<caption>${caption}</caption>` : ""
  const headerEle = `<tr>${headerList.map(item => `<th>${item}</th>`).join("")}</tr>`
  const cellEle = cellList
    .map(itemRow => `<tr>${itemRow.map(itemCell => `<td>${itemCell}</td>`).join("")}</tr>`)
    .join("")
  const excelContent = `${captionEle}${headerEle}${cellEle}`
  const worksheet = "Sheet1"
  const excelFile = `
    <html
      xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:x="urn:schemas-microsoft-com:office:excel"
      xmlns="http://www.w3.org/TR/REC-html40"
    >
      <head>
        <meta http-equiv="Conten-Type" content="text/html;charset=utf-8">
        <!--[if gte mso 9]>
        <xml>
          <x:ExcelWorkbook>
            <x:ExcelWorksheets>
              <x:ExcelWorksheet>
                <x:Name>${worksheet}</x:Name>
                <x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions>
              </x:ExcelWorksheet>
            </x:ExcelWorksheets>
          </x:ExcelWorkbook>
        </xml>
        <![endif]-->
      </head>
      <body><table>${excelContent}</table></body>
    </html>
  `
  const link = `data:application/vnd.ms-excel;base64,${trans2Base64(excelFile)}`
  const a = document.createElement("a")
  a.href = link
  a.download = `${exportName}.xlsx`
  a.click()
}

function exportExcelXlsxFrom() {
  const handleExport = {
    caption: "实时热点榜",
    headerList: ["排名", "热点名称", "热点变化趋势"],
    tableList: [
      {
        hot_level: "10671207",
        sentence: "易建联宣布退役",
        rank: "1"
      },
      {
        hot_level: "9864528",
        sentence: "日本核污水排放已累计超1500吨",
        rank: "2"
      },
      {
        hot_level: "9737465",
        sentence: "开学仪式感拉满了",
        rank: "3"
      },
      {
        hot_level: "9544002",
        sentence: "中元节不只是鬼节",
        rank: "4"
      },
      {
        hot_level: "9500300",
        sentence: "马克龙讥讽美国",
        rank: "5"
      },
      {
        hot_level: "9246281",
        sentence: "董明珠自曝70岁没保养",
        rank: "6"
      },
      {
        hot_level: "8946980",
        sentence: "澳洲现全球首例蛇蛔虫感染者",
        rank: "7"
      },
      {
        hot_level: "8797860",
        sentence: "苏拉或于9月1日登陆广东",
        rank: "8"
      },
      {
        hot_level: "8639452",
        sentence: "丰田日本全部14座工厂将停产",
        rank: "9"
      },
      {
        hot_level: "8541115",
        sentence: "河南鲁山通报715万建雕塑",
        rank: "10"
      }
    ],
    tableKey: ["rank", "sentence", "hot_level"],
    cellList: [
      ["排名", "热点名称", "热点变化趋势"],
      ["1", "易建联宣布退役", "10671207"],
      ["2", "日本核污水排放已累计超1500吨", "9864528"],
      ["3", "开学仪式感拉满了", "9737465"],
      ["4", "中元节不只是鬼节", "9544002"],
      ["5", "马克龙讥讽美国", "9500300"],
      ["6", "董明珠自曝70岁没保养", "9246281"],
      ["7", "澳洲现全球首例蛇蛔虫感染者", "8946980"],
      ["8", "苏拉或于9月1日登陆广东", "8797860"],
      ["9", "丰田日本全部14座工厂将停产", "8639452"],
      ["10", "河南鲁山通报715万建雕塑", "8541115"]
    ],
    exportName: "2023-08-30_实时热点榜"
  }
  var aoa = [
    ["姓名", "性别", "年龄", "注册时间"],
    ["张三", "男", 18, new Date()],
    ["李四", "女", 22, new Date()]
  ]

  var sheet = XLSX.utils.aoa_to_sheet(handleExport.cellList)
  openDownloadDialog(sheet2blob(sheet), `${handleExport.exportName}.xlsx`)
}

// 将一个sheet转成最终的excel文件的blob对象，然后利用URL.createObjectURL下载
function sheet2blob(sheet, sheetName) {
  sheetName = sheetName || "sheet1"
  var workbook = {
    SheetNames: [sheetName],
    Sheets: {}
  }
  workbook.Sheets[sheetName] = sheet
  // 生成excel的配置项
  var wopts = {
    bookType: "xlsx", // 要生成的文件类型
    bookSST: false, // 是否生成Shared String Table，官方解释是，如果开启生成速度会下降，但在低版本IOS设备上有更好的兼容性
    type: "binary"
  }
  var wbout = XLSX.write(workbook, wopts)
  var blob = new Blob([s2ab(wbout)], { type: "application/octet-stream" })
  // 字符串转ArrayBuffer
  function s2ab(s) {
    var buf = new ArrayBuffer(s.length)
    var view = new Uint8Array(buf)
    for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xff
    return buf
  }
  return blob
}

/**
 * 通用的打开下载对话框方法，没有测试过具体兼容性
 * @param url 下载地址，也可以是一个blob对象，必选
 * @param saveName 保存文件名，可选
 */
function openDownloadDialog(url, saveName) {
  if (typeof url == "object" && url instanceof Blob) {
    url = URL.createObjectURL(url) // 创建blob地址
  }
  var aLink = document.createElement("a")
  aLink.href = url
  aLink.download = saveName || "" // HTML5新增的属性，指定保存文件名，可以不要后缀，注意，file:///模式下不会生效
  var event
  if (window.MouseEvent) event = new MouseEvent("click")
  else {
    event = document.createEvent("MouseEvents")
    event.initMouseEvent(
      "click",
      true,
      false,
      window,
      0,
      0,
      0,
      0,
      0,
      false,
      false,
      false,
      false,
      0,
      null
    )
  }
  aLink.dispatchEvent(event)
}
