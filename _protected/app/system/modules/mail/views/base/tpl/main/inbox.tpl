{@if(empty($msg))@}

<p class="bold">{@lang('Sorry, this message was not found.')@}</p>

{@else@}

{* Set Variables *}
{{ $usernameSender = (empty($msg->username)) ? 'admin' : escape($msg->username) }}
{{ $firstNameSender = (empty($msg->firstName)) ? 'admin' : escape($msg->firstName) }}
{{ $subject = escape(Framework\Security\Ban\Ban::filterWord($msg->title)) }}
{{ $message = Framework\Parse\Emoticon::init(Framework\Security\Ban\Ban::filterWord($msg->message)) }}

<div class="center">

<dl>
 <dt>{@lang('Author :')@}</dt>
 <dd>{{ $avatarDesign->get($usernameSender, $firstNameSender, null, 32) }}</dd>
 <dt>{@lang('Date:')@}</dt>
 <dd>{% $dateTime->get($msg->sendDate)->dateTime() %}</dd>
 <dt>{@lang('Subject:')@}</dt>
 <dd>{subject}</dd>
 <dt>{@lang('Message:')@}</dt>
 <dd>{message}</dd>
</dl>

<div><a href="{{ $design->url('mail','main','compose',"$usernameSender,$subject") }}">{@lang('Reply')@}</a> | {{ LinkCoreForm::display(t('Delete'), 'mail', 'main', 'delete', array('id'=>$msg->messageId)) }}</div>

 </div>

 {@/if@}
