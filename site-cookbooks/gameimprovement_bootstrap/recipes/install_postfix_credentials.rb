secrets = data_bag_item("secrets", "gmail")
gmail_username = secrets['username']
gmail_password = secrets['password']

node['postfix']['smtp_sasl_user_name'] = gmail_username
node['postfix']['smtp_sasl_passwd'] = gmail_password
include_recipe "postfix::sasl_auth"
