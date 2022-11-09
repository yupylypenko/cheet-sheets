# How to generate SSL certs

https://docs.confluent.io/platform/current/security/security_tutorial.html#configuring-host-name-in-certificates

The script is [generate-certs](https://github.com/confluentinc/confluent-platform-security-tools/blob/master/kafka-generate-ssl.sh)

When run script CN should be FQDN hostname and country code of your country and the same password for all

For each host should be generated separate keystore but question to create trustore should be NO

Before run for the next host `mv keystore <hostname>`

After creation all of keystores it should be copied to certs forlder of servers

Additionaly, there could be created the keystore for klient