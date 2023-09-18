$(function() {

    function display_kasaekrani(bool) {
        if (bool) {
            $("#ekrani_kasa").show();
        } else {
            $("#ekrani_kasa").hide();
        }
    }

    display_kasaekrani(false);


    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "show_kasa_ekrani") {
            if (item.status == true) {
            
                meslek_kasasi_para = item.meslek_kasasi_para;
                para_cash = item.para_cash;
                meslek_ismi = item.meslek_ismi;

                if(meslek_kasasi_para == undefined) {
                    document.getElementById("ekrani_kasa").innerHTML='<img src="img/kasa_arkaplan.png" alt="">'
                    +'<p class="kasa_parasi">Kasadaki Para : 0$</p>'
                    +'<p class="ustundeki_parasi">Üstündeki Para : '+para_cash+'$</p>'
                    +'<div class="para_ekleme_alani"> <p class="kasaya_para_ekle_yazi">Kasaya Para Ekle : </p> <input id="input_paraeklee" class="input_kasapara" value="" type="number"> </div>'
                    +'<img class="btn_ekle" id="ekle_btn_click" src="img/ekle_btn.png" alt=""> '
                }
                else{
                    document.getElementById("ekrani_kasa").innerHTML='<img src="img/kasa_arkaplan.png" alt="">'
                    +'<p class="kasa_parasi">Kasadaki Para : '+meslek_kasasi_para+'$</p>'
                    +'<p class="ustundeki_parasi">Üstündeki Para : '+para_cash+'$</p>'
                    +'<div class="para_ekleme_alani"> <p class="kasaya_para_ekle_yazi">Kasaya Para Ekle : </p> <input id="input_paraeklee" class="input_kasapara" value="" type="number"> </div>'
                    +'<img class="btn_ekle" id="ekle_btn_click" src="img/ekle_btn.png" alt=""> '
                }
                
                document.getElementById("ekle_btn_click").addEventListener('click', function(event){

                    var eklenecek_para = document.getElementById("input_paraeklee").value;
                    //console.log(eklenecek_ara);
                    if(parseInt(para_cash) >= eklenecek_para){
                        $.post('http://zm_bossjobcase/kasaparaekle', JSON.stringify({
                            meslek : meslek_ismi,
                            para : eklenecek_para,
                
                        }));
                        return
                        
                    }
                    else{
                        $.post('http://zm_bossjobcase/hataver', JSON.stringify({
                            mesaj : "Yeterli nakit paran yok!",
                
                        }));
                        return
                    }
        
        
                });

                display_kasaekrani(true)
            } else {
                display_kasaekrani(false)
            }
            
        

        };


    });


    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://zm_bossjobcase/exit', JSON.stringify({}));
            return
        }
    };


})

