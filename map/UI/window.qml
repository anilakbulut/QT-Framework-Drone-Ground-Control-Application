import QtQuick 2.11
import QtQuick.Window 2.11
import QtLocation 5.11
import QtPositioning 5.8
import QtQuick.Controls 2.1

/*
    ANIL AKBULUT
    2.GOREV
*/


Item {

    //----------------------------
    //    UI MOCKUP AS IMAGE
    //----------------------------
    Image {
        id: ui
        x: 0
        y: 0
        width: 896
        height: 414
        source: "qrc:/UI/ui.png"
    }
    //----------------------------

    //-------------------------------------------------------------------------------
    //                                       MAP
    //-------------------------------------------------------------------------------
    Rectangle{
        x: 156
        y: 12
        width: 550
        height: 320

        /*Plugin ile arka planda calisan harita olusturuldu*/
        Plugin {
            id: mapPlugin
            name: "mapbox"

            PluginParameter {
                name: "mapbox.access_token"
                value: "pk.eyJ1IjoieGFzdGhvbiIsImEiOiJja3JxYmUya3QxcGMxMnZub2xpNGl2ZHVlIn0.TTzIxnKD0b8DAtWxXH62Vg"
            }
            PluginParameter {
                name: "mapbox.map_id"
                value: "mapbox.satellite"
            }

        }
        /*ListModel ile buton listesi olusturdum*/
        ListModel{
             id: listButton
        }
        /*
        Map tanimlandi
        Plugin ile ustte tanimlanan mapPlugin atandi
        zoomLevel uzaklastirma yakinlastirmayi gosterir
        center ile pozisyon tanimlandi
        */
        Map {
            id: map
            anchors.fill: parent
            plugin: mapPlugin
            zoomLevel: 15
            center: QtPositioning.coordinate(39.924991, 32.836864);
            MapItemView{
                model: listButton
                delegate: Marker{
                   coordinate: QtPositioning.coordinate(coords.latitude, coords.longitude)
                }
            }

            /*droneLine id'ye sahip olan haritada isaretlenen yerler arasindaki kirmizi cizgi olusturuldu*/
            Line{
                id: droneLine
            }

            /*droneSFLine id'ye sahip olan haritada isaretlenen yerler arasindaki
             Start ve Finish noktalari arasındaki mavi cizgi olusturuldu*/
            Line{
                id: droneSFLine
                line.color: 'blue'
            }

            /*start_point fonksiyonu ile program calistirildiginda ekrana gelen haritada
              belirtilen koordinatta bir baslanic noktasi olusturuldu
            */
            function start_point()
            {
                listButton.append({"coords": map.center})
                droneLine.addCoordinate(map.center)
                droneSFLine.addCoordinate(map.center)
            }

            /*Bilesen hazir oldugunda start_point fonksiyonu cagrildi*/
            Component.onCompleted: start_point()

            /*MouseArea'da tiklandigi zaman yeni bir konum eklenmesi,konumlar arasi cizgiler ayarlandi*/
            MouseArea{
                id: mouseArea
                anchors.fill: parent

                /*Tiklanildigi zaman listButton modeline koordinatlar eklendi (append ile)*/
                onClicked: {
                    var point = Qt.point(mouse.x, mouse.y)
                    var coord = map.toCoordinate(point);
                    listButton.append({"coords": coord})
                    droneLine.addCoordinate(coord)

                    /*Burada ise koordinatlar arasindaki kirmizi renkler ile
                      ilk ve son koordinat arasindaki mavi renkli cizgi ayarlandi
                    */
                    if(droneSFLine.pathLength() !== 2)
                    {
                        if(droneLine.pathLength() !== 2)
                            droneSFLine.addCoordinate(coord)
                    }
                    else
                    {
                        droneSFLine.replaceCoordinate(1,coord)
                    }
                    /*Tiklanan konumun koordinatlari terminale yazdirildi*/
                    console.log(coord.latitude, coord.longitude)
                }
            }

        }
    }


}

