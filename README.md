# Refleksi & Lesson Learnt
## Konsep Baru:  
Saya baru benar benar memahami proses serialization juga sebaliknya yaitu deserialization pada dart, untuk menyimpan data yang bentuknya list of object itu datanya tidak bisa langsung dimasukan, melainkan harus di urai terlebih dahulu menjadi teks panjang berformat JSON menggunakan jsonEncode(), lalu dikembalikan lagi dengan jsonDecode() ketika ingin ditampilkan.
## Kemenangan Kecil:
saya mendapatkan bug ketika sudah mengimplementasikan fitur pencarian, tampilan layat berhenti menjadi reactive, data yang baru saya tambahkan itu tidak muncul dan muncul ketika saya restar apk tersebut. lalu itu terjadi karena dair fitur pencarian tersendiri hanya memantau list Pencarian (filteredLogs), bukan pada list utama. saya menggunakan List.from() untuk sinkronisasi, agar sistem benar sadar setiap ada perubahan data.
## Target Berikutnya:
data masi tersimpan secara lokal permanen pada storage local hp, selanjutnya saya ingin mencoba database online atau mungkin API, agar tidak hilang jika apk dihapus dari perangkat pun sebaliknya.
