// const admin = require('firebase-admin');
// const serviceAccount = require("E:/Download/todoAPI.json"); // Đường dẫn đến file service account

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });

// const firestore = admin.firestore();
// const fs = require('fs');

// // Hàm để import dữ liệu từ file JSON
// async function importData(fileName) {
//   const filePath = `C:/Users/Victory/Downloads/json/${fileName}`; // Đường dẫn đến file JSON của bạn
//   const jsonData = JSON.parse(fs.readFileSync(filePath));

//   const qmsCollectionRef = firestore.collection('qms'); // Tạo reference cho collection 'qms'

//   // Kiểm tra và tạo sub-collection 'items' trong 'qms'
//   const problemCollectionRef = qmsCollectionRef.doc(fileName.split('.')[0]).collection('items'); // Tạo reference cho sub-collection 'items'

//   for (const item of jsonData) {
//     // Tạo document trong sub-collection 'items' với ID là 'document-1', 'document-2', ...
//     const itemRef = problemCollectionRef.doc(`${item.id}`);
//     // Lưu dữ liệu từ item vào Firestore
//     await itemRef.set(item); // Lưu cả object item mà không cần xác định cụ thể từng trường
//   }

//   console.log(`Dữ liệu từ file ${fileName} đã được import thành công!`);
// }

// // Gọi hàm importData cho nhiều file khác nhau
// async function importMultipleFiles() {
//   const filesToImport = ['iqc_report.json']; // Danh sách các file cần import

//   for (const file of filesToImport) {
//     await importData(file); // Gọi hàm importData cho từng file
//   }
// }

// importMultipleFiles().catch(console.error);

const admin = require('firebase-admin');
const serviceAccount = require("E:/Download/todoAPI.json"); // Đường dẫn đến file service account

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const firestore = admin.firestore();
const fs = require('fs');
const path = require('path');

// Hàm để import dữ liệu từ file JSON
async function importData(filePath, fileName) {
  const jsonData = JSON.parse(fs.readFileSync(filePath)); // Đọc file JSON

  const qmsCollectionRef = firestore.collection('qms'); // Tạo reference cho collection 'qms'

  // Kiểm tra và tạo sub-collection 'items' trong 'qms'
  const problemCollectionRef = qmsCollectionRef.doc(fileName.split('.')[0]).collection('items'); // Tạo reference cho sub-collection 'items'

  for (const item of jsonData) {
    // Tạo document trong sub-collection 'items' với ID là 'document-1', 'document-2', ...
    const itemRef = problemCollectionRef.doc(`${item.id}`);
    // Lưu dữ liệu từ item vào Firestore
    await itemRef.set(item); // Lưu cả object item mà không cần xác định cụ thể từng trường
  }

  console.log(`Dữ liệu từ file ${fileName} đã được import thành công!`);
}

// Hàm để import tất cả các file JSON trong folder
async function importFilesFromFolder(folderPath) {
  const files = fs.readdirSync(folderPath); // Đọc danh sách file trong folder

  const jsonFiles = files.filter(file => path.extname(file) === '.json'); // Lọc ra các file có đuôi .json

  for (const file of jsonFiles) {
    const filePath = path.join(folderPath, file); // Lấy đường dẫn đầy đủ của file
    await importData(filePath, file); // Gọi hàm importData cho từng file JSON
  }
}

// Gọi hàm importFilesFromFolder với đường dẫn đến folder chứa các file JSON
const folderPath = 'C:/Users/Victory/Downloads/json/pqc'; // Đường dẫn đến folder chứa các file JSON
importFilesFromFolder(folderPath).catch(console.error);
