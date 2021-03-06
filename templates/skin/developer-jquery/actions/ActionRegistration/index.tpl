{assign var="noSidebar" value=true}
{include file='header.tpl'}

<script type="text/javascript">
	jQuery(document).ready(function($){
		$('#registration-form').find('input.js-ajax-validate').blur(function(e){
			var aParams={ };
			if ($(e.target).attr('name')=='password_confirm') {
				aParams['password']=$('#user-password').val();
			}
			if ($(e.target).attr('name')=='password') {
				aParams['password']=$('#user-password').val();
				if ($('#user-password-confirm').val()) {
					ls.user.validateRegistrationField('password_confirm',$('#user-password-confirm').val(),$('#registration-form'),{ 'password': $(e.target).val() });
				}
			}
			ls.user.validateRegistrationField($(e.target).attr('name'),$(e.target).val(),$('#registration-form'),aParams);
		});
		$('#registration-form').bind('submit',function(){
			ls.user.registration('registration-form');
			return false;
		});
		$('#registration-form-submit').attr('disabled',false);
	});
</script>

<h2 class="page-header">{$aLang.registration}</h2>


<form action="{router page='registration'}" method="post" id="registration-form">
	{hook run='form_registration_begin'}

	<p><label for="login">{$aLang.registration_login}</label>
	<input type="text" name="login" id="login" value="{$_aRequest.login}" class="input-text input-width-300 js-ajax-validate" />
	<small class="validate-error-hide validate-error-field-login"></small>
	<small class="note">{$aLang.registration_login_notice}</small></p>

	<p><label for="mail">{$aLang.registration_mail}</label>
	<input type="text" name="mail" id="mail" value="{$_aRequest.mail}" class="input-text input-width-300 js-ajax-validate" />
	<small class="validate-error-hide validate-error-field-mail"></small>
	<small class="note">{$aLang.registration_mail_notice}</small></p>

	<p><label for="user-password">{$aLang.registration_password}</label>
	<input type="password" name="password" id="user-password" value="" class="input-text input-width-300 js-ajax-validate" />
	<small class="validate-error-hide validate-error-field-password"></small>
	<small class="note">{$aLang.registration_password_notice}</small></p>

	<p><label for="user-password-confirm">{$aLang.registration_password_retry}</label>
	<input type="password" value="" id="user-password-confirm" name="password_confirm" class="input-text input-width-300 js-ajax-validate" />
	<small class="validate-error-hide validate-error-field-password_confirm"></small></p>

	{hookb run="registration_captcha"}
	<p><label for="captcha">{$aLang.registration_captcha}</label>
	<img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}" 
		 onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
		 class="mb-10" /><br />
	<input type="text" name="captcha" id="captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
	<small class="validate-error-hide validate-error-field-captcha"></small></p>
	{/hookb}

	{hook run='form_registration_end'}

	<button name="submit_register" class="button button-primary" id="registration-form-submit" disabled="disabled">{$aLang.registration_submit}</button>
</form>



{include file='footer.tpl'}