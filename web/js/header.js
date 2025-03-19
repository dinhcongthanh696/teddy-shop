// Hàm toggle hiển thị/ẩn drop-down
function toggleDropdown() {
    document.getElementById("myDropdown").classList.toggle("show");
  }
  
  // Đóng drop-down khi click ra ngoài
  window.onclick = function(event) {
    if (!event.target.matches('.dropbtn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      for (var i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  };
  