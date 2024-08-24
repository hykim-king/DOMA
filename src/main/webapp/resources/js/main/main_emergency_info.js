function cctvInfo(accId) {
    $.ajax({
        url: "/doma/main/getNearestCctv.do",
        type: 'GET',
        data: { accId: accId },
        dataType: "json",
        success: function(response) {
        console.log(response);
            const acc = response.accident || {};
            const cctv = response.nearestCctv || {};

            var popupUrl = "/doma/main/popup.do?latitude=" + acc.latitude +
                "&longitude=" + acc.longitude +
                "&accName=" + encodeURIComponent(acc.accName) +
                "&accDName=" + encodeURIComponent(acc.accDName) +
                "&occrDate=" + acc.occrDate +
                "&occrTime=" + acc.occrTime +
                "&endDate=" + acc.endDate +
                "&endTime=" + acc.endTime +
                "&info=" + encodeURIComponent(acc.info) +
                "&cctvName=" + encodeURIComponent(cctv.cctvname) +
                "&cctvUrl=" + encodeURIComponent(cctv.cctvurl);
            
            window.open(popupUrl, "CCTV Popup", "width=600,height=400");
        },
        error: function(error) {
            console.error("Error: ", error);
        }
    });
}