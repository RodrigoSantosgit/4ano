
declare updating function local:change-email($old, $new)
{
  for $u in doc("users")//user
  where lower-case($u/mail) = $old
  return replace node $u/mail/text() with $new
  
};

local:change-email("var1","var2")