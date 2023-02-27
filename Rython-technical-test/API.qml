import QtQuick 2.15

QtObject {
    function getList(event,searchText,model)
    {
        var xhr = new XMLHttpRequest();

        let query = "event=" + event +"&"+ "searched-term="+searchText
        xhr.open("GET", "http://45.149.77.48:1123/api/visitor/pavilions"+"?"+query,true);
        xhr.responseType = 'json';
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.withCredentials = true;
        xhr.setRequestHeader("Authorization",
                             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjIsImF1ZCI6InZpc2l0b3IiLCJldmVudF9pZCI6MTgsImlhdCI6MTYyODc1NzIyM30.k8mj6z-AyryWsrXoDbA3N-mE_fZ5b1tcA__M1K9LI20"
                             );

        xhr.send(null);
        busyDialog.open()
        xhr.onabort =function(){
            console.log("Aborted.")
        }
        xhr.onreadystatechange = function ()
        {
            busyDialog.close()
            if (xhr.readyState === XMLHttpRequest.DONE)
            {
                model.clear()
                try
                {
                    let response = xhr.response

                    for( let i=0; i< response.pavilions.items.length;i++ )
                    {
                        var item = response.pavilions.items[i];
                        let bookmark= item.bookmark
                        let title = item.exhibitor.company_name
                        let category = item.exhibitor.field
                        let area = item.area
                        let booth = item.persian_name
                        model.append({"title":title,"category":category,"subtitle":item.description,"location":("سالن "+ area + " غرفه "+booth), "isBookmarked":bookmark})
                    }
                }
                catch(e) {
                    console.log(e)
                    return null
                }
            }
        }
    }
}
