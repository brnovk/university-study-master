<h1>Аутентификация:</h1>
<form name="auth-form" class="add-form form-about" action="authorization" method="post"
      onsubmit='return validateAuth("auth-form", "login", "password");'>
    <div class="cleafix">
        <label class="float-left" for="login"><strong>Логин:</strong></label>
        <input class="float-left" type="text" maxlength="255" size="40" name="login" id="login">
    </div>
    <div class="cleafix">
        <label class="float-left" for="password"><strong>Пароль:</strong></label>
        <input class="float-left" type="password" maxlength="255" size="40" name="password" id="password">
    </div>
    <input type="submit" value="Вход">
</form>