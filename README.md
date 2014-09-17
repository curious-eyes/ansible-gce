ansible-gce
===========
Ansible Playbook for starting Google Compute Engine instance.

### Spec:
- OS X 10.9.4
- Python 2.7.5
- Ansible 1.7.1

### Reference:
- [Ansible - Google Cloud Platform Guide](http://docs.ansible.com/guide_gce.html)

### Ready to play (Setting GCE module):
#### Step-1.
`sudo pip install apache-libcloud`

#### Step-2.
- Get `cacert.pem` file from http://curl.haxx.se/docs/caextract.html
- Save to `/credencials/cacert.pem`

#### Step-3.
- Create a new client ID and download the generated private key.
- (See more: http://docs.ansible.com/guide_gce.html#credentials)
- Save this file to `/credencials/pkey.pem`

#### Step-4.
- Rename `/credencials/secrets-sample.py` to `/credencials/secrets.py`.
- Edit this file.
- (See more: http://docs.ansible.com/guide_gce.html#calling-modules-with-secrets-py)

#### Step-5.
- Rename `/inventory/gce-sample.ini` to `/inventory/gce.ini`
- Set in the path to `secrets.py` like following.

   ```
   libcloud_secrets = /absolute/path/to/secrets.py
   ```

#### Step-6.
- Rename `/roles/gce/vars/main-sample.yml` to `/roles/gce/vars/main.yml`
- Set each properties like `secrets.py`.

### How to play:
#### Part-1. Create two instances and Load-balancing
```bash
$ gce_ansible.sh lb-sample.yml
```

#### Part-2. Create an instance and Setting WordPress
```bash
$ gce_ansible.sh wordpress.yml
```
