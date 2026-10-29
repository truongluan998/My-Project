# AI Video Studio

Quy trình tự động làm video kể chuyện minh hoạ bằng AI, kiểu kênh "người que + đếm ngược sinh tồn":

```
chủ đề ─▶ kịch bản (Claude) ─▶ ảnh từng cảnh (Gemini / OpenAI) ─▶ giọng đọc (Edge TTS / ElevenLabs)
       ─▶ phụ đề + chữ đếm ngược ─▶ dựng video Ken Burns + nhạc nền (ffmpeg) ─▶ thumbnail ─▶ YouTube
```

Chỉ cần một lệnh: `studio make "Power outage for 3 days, 1 hour to prepare"`.

## Thư viện sử dụng

| Bước | Thư viện | Ghi chú |
|---|---|---|
| Kịch bản | `anthropic` (Claude Opus 5.5) | Trả về JSON có cấu trúc: tiêu đề, mô tả, tags, các cảnh |
| Ảnh | `google-genai` (Gemini 2.5 Flash Image) hoặc `openai` (gpt-image-1) | Dùng ảnh tham chiếu để giữ nhân vật đồng nhất |
| Giọng đọc | `edge-tts` (miễn phí) hoặc `elevenlabs` (chất lượng cao) | |
| Dựng video | `ffmpeg` (zoompan, libass, sidechaincompress, loudnorm) | Nhanh và ổn định hơn MoviePy |
| Ảnh thumbnail | `pillow` | |
| Tải lên | `google-api-python-client` (YouTube Data API v3) | Tự đánh dấu "nội dung tạo bằng AI" |
| CLI | `typer`, `rich` | |

## Cài đặt

Bạn cần **Python 3.10+** và **ffmpeg**:
- Windows: `winget install ffmpeg`
- macOS: `brew install ffmpeg`
- Ubuntu: `sudo apt install ffmpeg`

```bash
cd AIVideoStudio
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -e .
cp .env.example .env             # rồi điền API key
```

API key cần có:
- `ANTHROPIC_API_KEY`: lấy tại https://platform.claude.com
- `GEMINI_API_KEY` (https://aistudio.google.com) **hoặc** `OPENAI_API_KEY`
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

# Toàn bộ quy trình trong một lệnh
studio make "Flood warning, water rising in 3 hours"

# Làm hàng loạt từ ideas.txt, tự tải lên YouTube (chế độ private)
studio batch ideas.txt --upload

# Tải lên YouTube
studio upload output/20261029-... --privacy unlisted
```

Mỗi tập nằm trong thư mục `output/<ngày>-<tên>/`:

```
script.json   images/   audio/   clips/   subtitles.ass   video.mp4   thumbnail.jpg
```

**Sửa một cảnh mà không phải làm lại cả video:** xoá hoặc thay `images/scene_05.png` (hoặc `audio/scene_05.mp3`), rồi chạy lại `studio build`. Chỉ phần còn thiếu hoặc đã thay đổi được tạo lại, nên không tốn thêm tiền API cho các cảnh khác.

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
