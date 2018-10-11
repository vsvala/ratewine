const WINEYARD = {}
// const wine_list=[]

WINEYARD.show = () => {
    $("#wineyardtable tr:gt(0)").remove()
    const table = $("#wineyardtable")

    WINEYARD.list.forEach((wineyard) => {
      console.log(wineyard)
      table.append('<tr>'
      + '<td>' + wineyard['name'] + '</td>'
      + '<td>' + wineyard['year']+ '</td>'
      + '<td>' + wineyard['active'] + '</td>'
      + '<td>' + wineyard['wine']['count']+ '</td>'
      + '</tr>')
    })
  }

  WINEYARD.sort_by_name = () => {
    WINEYARD.list.sort((a, b) => {
      return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    })
  }
  
  WINEYARD.sort_by_year = () => {
    WINEYARD.list.sort((a, b) => {
      return b.year-(a.year)
    })
  }
  
  WINEYARD.sort_by_wineammount = () => {
    WINEYARD.list.sort((a, b) => {
      return b.wines.count-(a.wines.count);
    })
  }


document.addEventListener("turbolinks:load", () => {
    if ($("#wineyardtable").length == 0) {
        return
      } 

    $("#name").click((e) => {
        e.preventDefault()
        WINEYARD.sort_by_name()
        WINEYARD.show()
      })

      $("#year").click((e) => {
        e.preventDefault()
        WINEYARD.sort_by_year()
        WINEYARD.show()
      })

      $("#wine").click((e) => {
        e.preventDefault()
        WINEYARD.sort_by_wineammount()
        WINEYARD.show()
      })

    $.getJSON('wineyards.json', (wineyards) => {
        WINEYARD.list = wineyards
        WINEYARD.show()    
      })
    })
