# AI Video Studio

Quy trình tự động làm video kể chuyện minh hoạ bằng AI, kiểu kênh "người que + đếm ngược sinh tồn":

```
chủ đề ─▶ kịch bản (Claude) ─▶ ảnh từng cảnh (Higgsfield) ─▶ giọng đọc + mốc thời gian từng chữ (Edge TTS / ElevenLabs)
       ─▶ dựng video động (Remotion) ─▶ chuẩn âm lượng (ffmpeg) ─▶ thumbnail ─▶ YouTube
```

Chỉ cần một lệnh: `studio make "Power outage for 3 days, 1 hour to prepare"`.

## Thư viện sử dụng

| Bước | Thư viện | Ghi chú |
|---|---|---|
| Kịch bản | `anthropic` (Claude Opus 5.5) | Trả về JSON có cấu trúc: tiêu đề, mô tả, tags, các cảnh |
| Ảnh | `higgsfield-client` (Higgsfield, mặc định), `google-genai` (Gemini) hoặc `openai` | Dùng ảnh tham chiếu để giữ nhân vật đồng nhất |
| Giọng đọc | `edge-tts` (miễn phí) hoặc `elevenlabs` (chất lượng cao) | |
| Dựng video | **Remotion** (React) | Zoom/lia mượt, đồng hồ đếm ngược chạy thật, phụ đề tô sáng từng chữ, chuyển cảnh mờ dần, nhạc tự nhỏ khi có lời, thanh tiến trình |
| Dựng video (dự phòng) | `ffmpeg` | Nhanh, không cần Node.js; hiệu ứng đơn giản hơn |
| Ảnh thumbnail | `pillow` | |
| Tải lên | `google-api-python-client` (YouTube Data API v3) | Tự đánh dấu "nội dung tạo bằng AI" |
| CLI | `typer`, `rich` | |

## Cài đặt

Bạn cần **Python 3.10+**, **Node.js 18+** (cho Remotion, https://nodejs.org) và **ffmpeg**:
- Windows: `winget install ffmpeg`
- macOS: `brew install ffmpeg`
- Ubuntu: `sudo apt install ffmpeg`

```bash
cd AIVideoStudio
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -e .
cp .env.example .env             # rồi điền API key
cd remotion && npm install && cd ..   # cài Remotion (lần đầu build cũng tự cài)
```

API key cần có:
- `ANTHROPIC_API_KEY`: lấy tại https://platform.claude.com
- `HF_KEY`: Higgsfield, lấy tại https://cloud.higgsfield.ai, dạng `api-key:api-secret`. Nếu dùng Gemini/OpenAI thì thay bằng `GEMINI_API_KEY` hoặc `OPENAI_API_KEY`.
- `ELEVENLABS_API_KEY`: chỉ cần nếu dùng `voice.provider: elevenlabs`

## Sử dụng

```bash
# Chạy thử miễn phí, không cần API key: ảnh giả và giọng câm, chỉ để kiểm tra máy đã chạy được ffmpeg
mkdir -p output/test && cp examples/power-outage.json output/test/script.json
studio build output/test --images placeholder --voice silent

# Gợi ý 20 chủ đề, lưu vào ideas.txt
studio ideas --count 20

# Cách làm khuyến nghị: viết kịch bản trước, đọc và sửa script.json, rồi mới dựng
studio script "Heat wave, 40°C, AC breaks, 2 hours until peak"
studio build output/20261029-heat-wave-...

# Xem trước trong Remotion Studio (trình duyệt), chỉnh hiệu ứng trong remotion/src rồi xem lại ngay
studio preview output/20261029-heat-wave-...

# Toàn bộ quy trình trong một lệnh
studio make "Flood warning, water rising in 3 hours"

# Làm hàng loạt từ ideas.txt, tự tải lên YouTube (chế độ private)
studio batch ideas.txt --upload

# Tải lên YouTube
studio upload output/20261029-... --privacy unlisted
```

Mỗi tập nằm trong thư mục `output/<ngày>-<tên>/`:

```
script.json   images/   audio/ (mp3 + mốc thời gian từng chữ)   props.json   video.mp4   thumbnail.jpg
```

**Sửa một cảnh mà không phải làm lại cả video:** xoá hoặc thay `images/scene_05.png` (hoặc `audio/scene_05.mp3`), rồi chạy lại `studio build`. Chỉ phần còn thiếu hoặc đã thay đổi được tạo lại, nên không tốn thêm tiền API cho các cảnh khác.

## Higgsfield và giữ nhân vật đồng nhất

Mặc định ảnh được tạo bằng model `bytedance/seedream/v4/text-to-image` trên Higgsfield. Để nhân vật giống hệt nhau qua các cảnh:

1. Tạo một ảnh nhân vật thật đẹp và đặt đường dẫn vào `images.character_reference`.
2. Vào danh mục model trên cloud.higgsfield.ai, chọn một model nhận ảnh tham chiếu (image-to-image / edit). Điền ID của model vào `images.higgsfield_reference_model`, và tên tham số nhận danh sách URL ảnh vào `higgsfield_reference_arg`.

Ảnh tham chiếu chỉ được tải lên Higgsfield một lần cho mỗi lần chạy.

## Hiệu ứng video (Remotion)

Mã nằm trong `remotion/src/`:
- `Scene.tsx`: zoom/lia ảnh, đồng hồ đếm ngược, phụ đề
- `Episode.tsx`: chuyển cảnh, nhạc nền, thanh tiến trình

Nếu `on_screen_text` của một cảnh có dạng `45:00`, nó sẽ thành đồng hồ chạy lùi thật. Chữ khác (như `12 L`) sẽ nảy lên.

Lưu ý:
- Remotion dựng chậm hơn ffmpeg (chụp từng khung hình qua Chrome), khoảng vài phút cho một video 3 phút tuỳ máy. Cần nhanh thì dùng `--renderer ffmpeg`.
- Nếu Remotion không tự tải được Chrome, đặt biến `REMOTION_BROWSER_EXECUTABLE` trỏ tới Chrome/Chromium có sẵn trong máy.
- Giấy phép: Remotion miễn phí cho cá nhân và công ty nhỏ. Công ty đông người hơn cần mua license, xem https://remotion.dev/license.

## Tuỳ biến kênh của bạn: `config.yaml`

- `channel`: nhân vật, phong cách vẽ, cấu trúc tập. Đây là phần quan trọng nhất, quyết định "chất" của kênh.
- `images.character_reference`: một ảnh nhân vật chuẩn. Nên tạo một ảnh thật đẹp rồi đặt ở đây để mọi tập dùng chung một nhân vật.
- `voice`: chọn giọng.
  - Danh sách giọng Edge: `edge-tts --list-voices`
  - Giọng tiếng Việt: `vi-VN-HoaiMyNeural`, `vi-VN-NamMinhNeural`
- `video.music_dir`: thả vài file nhạc không bản quyền vào `assets/music/`. Nhạc tự động nhỏ lại khi có lời đọc.
- Muốn làm video tiếng Việt: đổi `channel.language: "Vietnamese"` và chọn giọng `vi-VN-...`.

## Tải lên YouTube (một lần thiết lập)

1. Vào Google Cloud Console, tạo project và bật **YouTube Data API v3**.
2. Tạo **OAuth client ID** loại *Desktop app*, tải file JSON về và lưu thành `AIVideoStudio/client_secret.json`.
3. Lần đầu chạy `studio upload`, trình duyệt sẽ mở để bạn đăng nhập. Token được lưu vào `youtube_token.json`.

Lưu ý:
- Project mới chưa được Google xác minh thì video tải lên qua API có thể bị khoá ở chế độ private cho đến khi project qua bước kiểm tra (audit) của YouTube. Chế độ mặc định là `private` để bạn duyệt trước khi công khai.
- Muốn đặt thumbnail tuỳ chỉnh, kênh cần xác minh số điện thoại.

## Chi phí và chính sách

- Giá các dịch vụ thay đổi thường xuyên, hãy xem trang giá của từng bên. Phần tốn nhất thường là tạo ảnh (khoảng 14 ảnh mỗi video). Giọng Edge TTS miễn phí.
- YouTube không cho kiếm tiền với nội dung "hàng loạt, lặp lại". Hãy đọc và sửa kịch bản trước khi dựng, kiểm tra các con số an toàn với nguồn chính thức (`sources` trong `script.json` được tự động thêm vào mô tả video), và giữ chất lượng đều.
- Video được đánh dấu `containsSyntheticMedia` khi tải lên.

## Hướng phát triển tiếp

- Chuyển ảnh tĩnh thành clip chuyển động (Kling, Veo, Runway) cho các cảnh quan trọng
- Phụ đề khớp từng từ bằng `faster-whisper`
- Thêm hiệu ứng âm thanh theo từng cảnh (ElevenLabs Sound Effects)
- Tạo phiên bản Shorts 9:16 từ cùng một kịch bản
