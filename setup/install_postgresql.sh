# Update all packages
sudo yum -y update


# Install the repository RPM
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm


# Prevent from OLD postgre packeages
repo="/etc/yum.repos.d/CentOS-Base.repo"
cp -p ${repo} /tmp
sudo vi ${repo} # -> 旧バージョンのpostgreがインストールされないように[base]と[updates]の末尾に"exclude=postgresql*"を追加する
diff ${repo} /tmp/${repo##*/}


# Install PostgreSQL
# - postgresql11          # クライアントプログラムとライブラリ
# - postgresql11-libs     # 共有ライブラリ
# - postgresql11-llvmjit  # JITコンパイラ
# - postgresql11-server   # サーバープログラム
# - postgresql11-docs     # ドキュメント
# - postgresql11-contrib  # 追加モジュール
# - postgresql11-devel    # 開発ヘッダーファイルとライブラリ
# - postgresql11-plperl   # PL/Perl
# - postgresql11-plpython # PL/Python
# - postgresql11-pltcl    # PL/Tcl
# - postgresql11-test     # テストスイート
sudo yum install -y postgresql11*
sudo yum list installed | grep -i "postgresql"


# Set potgre to start automatically
sudo su -
systemctl enable postgresql-11.service
echo $?


# Change password for "postgres"
sudo su -
passwd postgres # -> "p@ssw0rd"に設定


# Edit .bash_profile for "postgres"
su - postgres
ll ~postgres/.bash_profile
profile="${HOME}/.bash_profile"
[ -f ${profile}.org ] || cp -p ${profile} ${profile}.org
vi ${profile}
# ---
PATH=/usr/pgsql-11/bin:$PATH
MANPATH=/usr/pgsql-11/share/man:$MANPATH
export PATH MANPATH PGDATA
# ---
diff ${profile} ${profile}.org
source ${profile}
