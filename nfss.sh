echo "Переключение на суперпользователя"
sudo su
echo "Установка утилит nfs"
yum install nfs-utils -y
echo "Включение файервола"
systemctl enable firewalld --now
echo "Включение запуска сервисов в файерволе"
firewall-cmd --permanent --add-service="nfs3"
firewall-cmd --permanent --add-service="rpc-bind"
firewall-cmd --permanent --add-service="mountd"
echo "Перезагрузка файервола"
firewall-cmd --reload
systemctl status firewalld
echo "Включение сервера NFS"
systemctl enable nfs --now
systemctl status nfs
echo "Прверка работы портов сервера NFS: 2049/udp, 2049/tcp, 20048/udp, 20048/tcp,
111/udp, 111/tcp"
ss -tnplu
echo "Создание директорий экспорта"
mkdir -p /srv/share/upload
echo "Замена владельца и группы на nfsnobody"
chown -R nfsnobody:nfsnobody /srv/share
echo "Открытие всех прав на директорию"
chmod 0777 /srv/share/upload
echo "Прописываем адрес клиента и права синхронизации"
echo "/srv/share 192.168.50.11/32(rw,sync,root_squash)" >> /etc/exports
echo "Запускаем экспорт"
exportfs -r
echo "Проверяем запуск экспорта"
exportfs -s
echo "Создаем несколько файлов для тестирования экспорта"
touch /srv/share/upload/file_server{1..3}
