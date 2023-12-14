# homework6
```
Сервер
1 Переключение на суперпользователя
   sudo su
1 Установка утилит nfs
  yum install nfs-utils -y
1 Включение файервола
  systemctl enable firewalld --now
1 Включение запуска сервисов в файерволе
  firewall-cmd --permanent --add-service="nfs3"
  firewall-cmd --permanent --add-service="rpc-bind"
  firewall-cmd --permanent --add-service="mountd"
1 Перезагрузка файервола
  firewall-cmd --reload
  systemctl status firewalld
1 Включение сервера NFS
  systemctl enable nfs --now
  systemctl status nfs
1 Прверка работы портов сервера NFS: 2049/udp, 2049/tcp, 20048/udp, 20048/tcp,
111/udp, 111/tcp
  ss -tnplu
1 Создание директорий экспорта
  mkdir -p /srv/share/upload
1 Замена владельца и группы на nfsnobody
  chown -R nfsnobody:nfsnobody /srv/share
1 Открытие всех прав на директорию
  chmod 0777 /srv/share/upload
1 Прописываем адрес клиента и права синхронизации
  echo "/srv/share 192.168.50.11/32(rw,sync,root_squash)" >> /etc/exports
1 Запускаем экспорт
  exportfs -r
1 Проверяем запуск экспорта
  exportfs -s
1 Создаем несколько файлов для тестирования экспорта
  touch /srv/share/upload/file_server{1..3}

Клиент
1 Переключение на суперпользователя
  sudo su
1 Установка утилит nfs
  yum install nfs-utils -y
1 Включение файервола
  systemctl enable firewalld --now
  systemctl status firewalld
1 Включение сервера NFS
  systemctl enable nfs --now
  systemctl status nfs
1 Добавляем в fstab директорию экспорта сервера для подключения после reload'a systemd
  echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
1 Перегружаем systemd и перезапускаем службу удаленных файловых систем
  systemctl daemon-reload
  systemctl restart remote-fs.target
1 Проверка успешности монтирования сетевого диска
  mount | grep mnt
1 Если перезагрузка и перезапуск не помогает, используем обычное монтирование
  mount 192.168.50.10:/srv/share/ /mnt/
1 Проверка успешности монтирования сетевого диска"
  mount | grep mnt
```
