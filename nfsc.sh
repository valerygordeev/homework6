echo "Переключение на суперпользователя"
sudo su
echo "Установка утилит nfs"
yum install nfs-utils -y
echo "Включение файервола"
systemctl enable firewalld --now
systemctl status firewalld
echo "Включение сервера NFS"
systemctl enable nfs --now
systemctl status nfs
echo "Добавляем в fstab директорию экспорта сервера для подключения после reload'a systemd"
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
echo "Перегружаем systemd и перезапускаем службу удаленных файловых систем"
systemctl daemon-reload
systemctl restart remote-fs.target
echo "Проверка успешности монтирования сетевого диска"
mount | grep mnt
echo "Монтируем сервер"
mount 192.168.50.10:/srv/share/ /mnt/
echo "Проверка успешности монтирования сетевого диска"
mount | grep mnt
#echo "Создаем несколько файлов для тестирования экспорта"
#touch /mnt/upload/file_client{1..3}
