/**
 * Hàm chuyển đổi số tiền thành chữ tiếng Việt
 * Hỗ trợ số lớn đến hàng nghìn tỷ (tối đa 15 chữ số)
 * 
 * @param {number} amount - Số tiền cần chuyển đổi (integer hoặc float)
 * @returns {string} - Chuỗi chữ tiếng Việt
 * 
 * @example
 * convertMoneyToVietnameseText(1250000) // "Một triệu hai trăm năm mươi nghìn đồng"
 * convertMoneyToVietnameseText(1000) // "Một nghìn đồng"
 * convertMoneyToVietnameseText(1234567890) // "Một tỷ hai trăm ba mươi bốn triệu năm trăm sáu mươi bảy nghìn tám trăm chín mươi đồng"
 */
function convertMoneyToVietnameseText(amount) {
    // Xử lý đầu vào: chuyển thành số nguyên (làm tròn nếu là số thập phân)
    let num = Math.round(parseFloat(amount));
    
    // Xử lý trường hợp đặc biệt
    if (isNaN(num) || num < 0) {
        return "Không hợp lệ";
    }
    
    if (num === 0) {
        return "Không đồng";
    }
    
    // Giới hạn số lớn nhất: 999.999.999.999.999 (hàng nghìn tỷ)
    if (num > 999999999999999) {
        return "Số quá lớn";
    }
    
    // Mảng chữ số đơn vị
    const ones = ["", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"];
    
    // Mảng chữ số hàng chục
    const tens = ["", "mười", "hai mươi", "ba mươi", "bốn mươi", "năm mươi", 
                  "sáu mươi", "bảy mươi", "tám mươi", "chín mươi"];
    
    /**
     * Hàm chuyển đổi một nhóm 3 chữ số thành chữ
     * @param {number} n - Số từ 0 đến 999
     * @returns {string} - Chuỗi chữ tương ứng
     */
    function convertThreeDigits(n) {
        if (n === 0) return "";
        
        let result = "";
        let hundred = Math.floor(n / 100);
        let remainder = n % 100;
        let ten = Math.floor(remainder / 10);
        let one = remainder % 10;
        
        // Xử lý hàng trăm
        if (hundred > 0) {
            result += ones[hundred] + " trăm";
            if (remainder === 0) {
                return result;
            } else if (remainder < 10) {
                result += " linh ";
            } else {
                result += " ";
            }
        }
        
        // Xử lý hàng chục
        if (ten > 0) {
            if (ten === 1 && one === 0) {
                result += "mười";
            } else if (ten === 1 && one > 0) {
                result += "mười " + (one === 5 ? "lăm" : (one === 1 ? "mốt" : ones[one]));
            } else {
                result += tens[ten];
                if (one > 0) {
                    result += " " + (one === 5 ? "lăm" : (one === 1 ? "mốt" : ones[one]));
                }
            }
        } else if (one > 0) {
            // Chỉ có hàng đơn vị
            if (hundred > 0) {
                result += "linh " + ones[one];
            } else {
                result += ones[one];
            }
        }
        
        return result.trim();
    }
    
    /**
     * Hàm chuyển đổi số thành chữ
     * @param {number} num - Số cần chuyển đổi
     * @returns {string} - Chuỗi chữ tương ứng
     */
    function convertNumber(num) {
        if (num === 0) return "không";
        
        let result = "";
        let groups = [];
        let temp = num;
        
        // Chia số thành các nhóm 3 chữ số (từ phải sang trái)
        while (temp > 0) {
            groups.push(temp % 1000);
            temp = Math.floor(temp / 1000);
        }
        
        // Tên các đơn vị hàng
        const units = ["", "nghìn", "triệu", "tỷ", "nghìn tỷ"];
        
        // Xử lý từng nhóm từ trái sang phải (từ nhóm lớn nhất)
        for (let i = groups.length - 1; i >= 0; i--) {
            let groupValue = groups[i];
            let unitIndex = i; // Chỉ số đơn vị hàng
            
            // Bỏ qua nhóm 0
            if (groupValue === 0) {
                continue;
            }
            
            let groupText = convertThreeDigits(groupValue);
            
            if (groupText) {
                // Thêm khoảng trắng nếu đã có kết quả trước đó
                if (result) {
                    result += " ";
                }
                
                result += groupText;
                
                // Thêm đơn vị hàng (nghìn, triệu, tỷ...)
                if (unitIndex > 0 && units[unitIndex]) {
                    result += " " + units[unitIndex];
                }
            }
        }
        
        return result.trim();
    }
    
    // Chuyển đổi số
    let text = convertNumber(num);
    
    // Chữ cái đầu tiên viết hoa
    if (text) {
        text = text.charAt(0).toUpperCase() + text.slice(1);
    }
    
    // Thêm "đồng" vào cuối
    text += " đồng";
    
    return text;
}

