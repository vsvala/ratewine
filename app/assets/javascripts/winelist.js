const WINES = {}
// const wine_list=[]

WINES.show = () => {
    $("#winetable tr:gt(0)").remove()
    const table = $("#winetable")

    WINES.list.forEach((wine) => {
      table.append('<tr>'
      + '<td>' + wine['name'] + '</td>'
      + '<td>' + wine['style']['name'] + '</td>'
      + '<td>' + wine['wineyard']['name'] + '</td>'
      + '</tr>')
    })

    // WINES.list.forEach( (wine) => {
    //     wine_list.push('<li>' + wine['name'] + '</li>')    
    // })

    // $("#wines").html('<ul>'+ wine_list.join('') + '</ul>')

    }

//     WINES.reverse = () => {
//     WINES.list.reverse()
//   } 

  WINES.sort_by_name = () => {
    WINES.list.sort((a, b) => {
      return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    })
  }
  
  WINES.sort_by_style = () => {
    WINES.list.sort((a, b) => {
      return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase())
    })
  }
  
  WINES.sort_by_wineyard = () => {
    WINES.list.sort((a, b) => {
      return a.wineyard.name.toUpperCase().localeCompare(b.wineyard.name.toUpperCase());
    })
  }


document.addEventListener("turbolinks:load", () => {
    if ($("#winetable").length == 0) {
        return
      } 

    // $("#reverse").click((e) => {
    //     e.preventDefault()
    //     WINES.reverse()
    //     WINES.show()
    //   })

    $("#name").click((e) => {
        e.preventDefault()
        WINES.sort_by_name()
        WINES.show()
      })

      $("#style").click((e) => {
        e.preventDefault()
        WINES.sort_by_style()
        WINES.show()
      })

      $("#wineyard").click((e) => {
        e.preventDefault()
        WINES.sort_by_wineyard()
        WINES.show()
      })

    $.getJSON('wines.json', (wines) => {
        WINES.list = wines
        WINES.show()    
      })
    })
