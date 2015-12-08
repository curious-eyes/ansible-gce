ansible-gce
===========
Ansible Playbook for starting Google Compute Engine instance.

### Spec:
- OS X 10.9.4
- Python 2.7.5
- Ansible 1.7.1

### Reference:
- [Ansible - Google Cloud Platform Guide](http://docs.ansible.com/guide_gce.html)
- [AnsibleでGCEインスタンスを管理する](http://qiita.com/curious-eyes/items/c7feb3edbeb7c7c640e6) - [Qiita](http://qiita.com/curious-eyes)

### Ready to play (Setting GCE module):
#### Step-1.
`sudo pip install apache-libcloud`

#### Step-2.
- You can create new credential from the [console](https://console.developers.google.com/) by going to the "APIs and Auth" section and choosing to create a new client ID for a service account.
- Once you’ve created a new client ID and downloaded the generated private key, you'll save pkcs12 format file to `/credentials/~filename~.p12`

### How to play:
#### Part-1. Create two instances and Load-balancing
```bash
$ gce_ansible.sh lb-sample.yml
```

#### Part-2. Create an instance and Setting WordPress
```bash
$ gce_ansible.sh wordpress.yml
```
