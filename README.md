[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

---
# de.seafi.minimalinstall

ansible-role for deploying a baselining on fresh installed machines.


## Role Vars

| Var        | default value      | description                          |
|--------------|--------------------|--------------------------------------|
| ansible_user     |                    | ansible management user              |
| ansible_user_pwd |                    | ansible user password                |
| TZONE            | 'Europe/Berlin'    | Time zone which should be configured |
| TIMESERVER       | 'time.fu-berlin.de | Timeserver for synchro               | 