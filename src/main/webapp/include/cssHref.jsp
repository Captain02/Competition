    <%
	      pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/static/css/reset.css">
    <link rel="stylesheet" href="${APP_PATH}/static/css/style.css">
    
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/js/change.js"></script>
    <script src="${APP_PATH}/static/js/ctrolButton.js"></script>
    
    <!-- emoji表情插件 -->
	<link rel="stylesheet" href="${APP_PATH}/static/emoji-picker/lib/css/emoji.css">
	<script src="${APP_PATH}/static/emoji-picker/lib/js/config.js"></script>
	<script src="${APP_PATH}/static/emoji-picker/lib/js/util.js"></script>
	<script src="${APP_PATH}/static/emoji-picker/lib/js/jquery.emojiarea.js"></script>
	<script src="${APP_PATH}/static/emoji-picker/lib/js/emoji-picker.js"></script>