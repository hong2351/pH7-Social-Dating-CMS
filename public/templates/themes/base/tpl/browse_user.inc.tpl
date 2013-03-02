<div class="box-left">

  <div role="search" class="design-box">
  <h2>{@lang('Quick Search')@}</h2>
  {{ SearchUserCoreForm::quick(168) }}
  </div>

</div>

<div class="box-right">

{@if(empty($users))@}

  <p class="center bold">{@lang('Whoops! Not Found Users.')@}</p>

{@else@}

<h3 class="center">{@lang('Total Users: %0%', $total_users)@}</h3>


{@foreach($users as $user)@}

{{ $country_name = t($user->country) }}

{* Age Members *}
{{ $aAge = explode('-', $user->birthDate);
$oUser = new UserCore();
$age = $oUser->getAge($aAge[0], $aAge[1], $aAge[2]);
unset($oUser) }}

<div class="thumb_photo">
{{ UserDesignCoreModel::userStatus($user->profileId) }}

{* Sex Icon *}
{@if($user->sex === 'male')@}
  {{ $sex_ico = ' <span class=green>&#9794;</span>' }}
{@elseif($user->sex === 'female')@}
  {{ $sex_ico = ' <span class=pink>&#9792;</span>' }}
{@else@}
 {{ $sex_ico = '' }}
{@/if@}

{{ $oAvatarDesign->get($user->username, $user->firstName, $user->sex, 100, 'rollover') }}
<p class="cy_ico"><a href="{url_root}{% $user->username %}{page_ext}" title="{@lang('First name: %0%', $user->firstName)@}<br> {@lang('Sex: %0% %1%', t($user->sex), $sex_ico)@}<br> {@lang('Seeking %0%', t($user->matchSex))@}<br> {@lang('Age: %0%', $age)@}<br> {@lang('From %0%', $country_name)@}<br> {@lang('City %0%', $this->str->upperFirst($user->city))@}<br> {@lang('State %0%', $this->str->upperFirst($user->state))@}"><strong>{% substr($user->username,0,16) %}</strong></a> &nbsp; <img src="{{ $design->getSmallFlagIcon($user->country) }}" alt="{country_name}" title="{@lang('From %0%', $country_name)@}" /></p>

{@if(AdminCore::auth())@}
    <p class="small"><a href="{{ $design->url(PH7_ADMIN_MOD,'user','loginuseras',$user->profileId) }}" title="{@lang('Login As a member')@}">{@lang('Login as')@}</a> |

    {@if($user->ban == '0')@}
     {{ $design->popupLinkConfirm(t('Ban'), PH7_ADMIN_MOD, 'user', 'ban', $user->profileId) }}
    {@else@}
     {{ $design->popupLinkConfirm(t('UnBan'), PH7_ADMIN_MOD, 'user', 'unban', $user->profileId) }}
    {@/if@}

    | <br />{{ $design->popupLinkConfirm(t('Delete'), PH7_ADMIN_MOD, 'user', 'delete', $user->profileId.'_'.$user->username) }} |
    <a href="{% Framework\Ip\Ip::api($user->ip) %}" title="{@lang('See information from this user IP')@}" target="_blank">{% $user->ip %}</a>
    </p>
{@/if@}

</div>

{@/foreach@}


{@main_include('page_nav.inc.tpl')@}

{@/if@}

</div>
