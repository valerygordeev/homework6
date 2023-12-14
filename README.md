# homework6
```
Сервер
1 Переключение на суперпользователя
   sudo su
2 Установка утилит nfs
  yum install nfs-utils -y
3 Включение файервола
  systemctl enable firewalld --now
4 Включение запуска сервисов в файерволе
  firewall-cmd --permanent --add-service="nfs3"
  firewall-cmd --permanent --add-service="rpc-bind"
  firewall-cmd --permanent --add-service="mountd"
5 Перезагрузка файервола
  firewall-cmd --reload
  systemctl status firewalld
6 Включение сервера NFS
  systemctl enable nfs --now
  systemctl status nfs
7 Прверка работы портов сервера NFS: 2049/udp, 2049/tcp, 20048/udp, 20048/tcp,
111/udp, 111/tcp
  ss -tnplu
8 Создание директорий экспорта
  mkdir -p /srv/share/upload
9 Замена владельца и группы на nfsnobody
  chown -R nfsnobody:nfsnobody /srv/share
10 Открытие всех прав на директорию
  chmod 0777 /srv/share/upload
11 Прописываем адрес клиента и права синхронизации
  echo "/srv/share 192.168.50.11/32(rw,sync,root_squash)" >> /etc/exports
12 Запускаем экспорт
  exportfs -r
13 Проверяем запуск экспорта
  exportfs -s
14 Создаем несколько файлов для тестирования экспорта
  touch /srv/share/upload/file_server{1..3}

Клиент
1 Переключение на суперпользователя
  sudo su
2 Установка утилит nfs
  yum install nfs-utils -y
3 Включение файервола
  systemctl enable firewalld --now
  systemctl status firewalld
4 Включение сервера NFS
  systemctl enable nfs --now
  systemctl status nfs
5 Добавляем в fstab директорию экспорта сервера для подключения после reload'a systemd
  echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
6 Перегружаем systemd и перезапускаем службу удаленных файловых систем
  systemctl daemon-reload
  systemctl restart remote-fs.target
7 Проверка успешности монтирования сетевого диска
  mount | grep mnt
8 Если перезагрузка и перезапуск не помогает, используем обычное монтирование
  mount 192.168.50.10:/srv/share/ /mnt/
9 Проверка успешности монтирования сетевого диска"
  mount | grep mnt
```
