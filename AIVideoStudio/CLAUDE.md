# AIVideoStudio: ghi chú bàn giao cho các phiên làm việc sau

Đọc file này trước khi làm gì trong `AIVideoStudio/`. Hướng dẫn cho người dùng cuối nằm ở `README.md`.
Khi làm xong một việc, hãy cập nhật mục **Trạng thái** và **Việc cần làm tiếp** bên dưới.

## Mục tiêu

Người dùng (nói tiếng Việt, hãy trả lời bằng tiếng Việt) muốn làm kênh YouTube video kể chuyện minh hoạ bằng AI. Kênh tham khảo là "Melvin Wont Die":
- người que vẽ mực và màu gouache;
- mỗi tập là một cuộc "đếm ngược sinh tồn" khoảng 3 phút;
- có mẹo sinh tồn thật, kèm con số cụ thể.

Người dùng **không sao chép** kênh đó. Họ tạo nhân vật riêng: **Pip**, người que mặc áo mưa vàng, vẽ phong cách màu nước và bút chì.

Mục tiêu dài hạn là quy trình **tự động hoàn toàn**: chủ đề → video → YouTube, chạy được hàng loạt.

## Kiến trúc

```
studio make "<chủ đề>"
  1. script_writer.py   Claude (anthropic SDK, claude-opus-5-5) → models.Episode (JSON có cấu trúc)
  2. images.py          higgsfield (mặc định) | gemini | openai | placeholder → images/scene_XX.png 1920x1080
  3. voice.py           edge (mặc định, miễn phí) | elevenlabs | silent → audio/scene_XX.mp3 + scene_XX.words.json
  4. renderer_remotion  props.json → `npx remotion render` (remotion/) → ffmpeg loudnorm -14 LUFS → video.mp4
     (hoặc video.py + subtitles.py: renderer ffmpeg dự phòng, ASS subtitles + zoompan)
  5. thumbnail.py       Pillow → thumbnail.jpg 1280x720
  6. youtube.py         YouTube Data API v3, mặc định private, containsSyntheticMedia=True
```

**File chính**
- `config.yaml`: "series bible" (nhân vật, phong cách, cấu trúc tập) và mọi lựa chọn provider/renderer.
- `.env`: API key, xem `.env.example`. Các biến: `ANTHROPIC_API_KEY`, `HF_KEY`, `GEMINI_API_KEY`, `OPENAI_API_KEY`, `ELEVENLABS_API_KEY`.
- `studio/cli.py` (typer). Các lệnh: `ideas`, `script`, `build`, `preview`, `make`, `batch`, `upload`.
  - Tuỳ chọn ghi đè: `--images`, `--voice`, `--renderer`.
- `remotion/src/`:
  - `Root.tsx`: `calculateMetadata` lấy fps, kích thước và thời lượng từ props.
  - `Episode.tsx`: TransitionSeries fade, nhạc nền tự nhỏ đi dựa trên mốc thời gian từng chữ, thanh tiến trình.
  - `Scene.tsx`: Ken Burns, đồng hồ đếm ngược `mm:ss` chạy thật, phụ đề tô sáng từng chữ, font Bangers + Inter qua `@remotion/google-fonts`.
  - `types.ts`: kiểu dữ liệu của `props.json`. Nếu sửa, phải sửa đồng thời `renderer_remotion.write_props`.
- `examples/power-outage.json`: kịch bản mẫu 6 cảnh, dùng để test không cần API.
- Mỗi tập nằm ở `output/<YYYYMMDD>-<slug>/` (đã gitignore).

**Quy ước quan trọng**
- **Chạy lại không tốn tiền:** bước ảnh và giọng bỏ qua file đã tồn tại. Muốn làm lại một cảnh thì xoá file của cảnh đó.
- **Cách giữ nhân vật đồng nhất:**
  - Nếu có `images.character_reference` thì dùng ảnh đó làm tham chiếu.
  - Nếu không, ảnh cảnh 1 được dùng làm tham chiếu cho các cảnh sau.
  - Với Higgsfield, ảnh tham chiếu chỉ được dùng khi `higgsfield_reference_model` có giá trị.
- **Remotion:**
  - `--public-dir` trỏ vào thư mục tập, nên đường dẫn trong props là tương đối với thư mục tập.
  - File nhạc được copy vào thư mục tập.
  - Tất cả gói `remotion` và `@remotion/*` phải **cùng một phiên bản chính xác** (hiện là 4.0.539).
- `transitionFrames` bị giới hạn ≤ `pause_after_scene * fps`, để phần chồng lên nhau khi chuyển cảnh chỉ rơi vào khoảng lặng.
- **Gọi Claude:**
  - Dùng `client.beta.messages.parse` với `output_format=Episode`, thinking adaptive, `output_config.effort`.
  - Có bật `fallbacks="default"` + beta `server-side-fallback-2026-07-01`.
  - SDK anthropic 2.x dùng `httpx2`, không phải `httpx`. Khi mock trong test phải dùng `httpx2`.
- Docstring và thông báo CLI viết bằng tiếng Việt; comment trong code viết bằng tiếng Anh.

## Trạng thái (cập nhật 2026-10-29)

**Đã làm và đã test trong sandbox** (với ảnh `placeholder` và giọng `silent`):
- Toàn bộ quy trình bằng cả hai renderer: remotion và ffmpeg.
- Video 1920x1080 h264, âm thanh đạt -14 LUFS.
- Thumbnail.
- Nhạc nền tự nhỏ khi có lời đọc.

**Chỉ test bằng mock, CHƯA gọi API thật** (sandbox không có key và mạng bị chặn):
- Claude: đã kiểm tra request đúng định dạng.
- Higgsfield: đã kiểm tra chỉ upload ảnh tham chiếu một lần.

**Chưa test chút nào:**
- Gemini, OpenAI images.
- ElevenLabs.
- Edge TTS: sandbox chặn `speech.platform.bing.com`.
- YouTube upload.

**Còn mở:**
- Chưa biết model Higgsfield nào nhận ảnh tham chiếu và tên tham số của nó. Không truy cập được docs (docs.higgsfield.ai bị chặn). Hiện `higgsfield_reference_model: ""` và `higgsfield_reference_arg: "image_urls"` chỉ là phỏng đoán. Người dùng cần lấy thông tin này từ cloud.higgsfield.ai.
- Model mặc định `bytedance/seedream/v4/text-to-image` lấy từ README chính thức của `higgsfield-client`.

## Việc cần làm tiếp (theo thứ tự ưu tiên)

1. Người dùng chạy thật trên máy của họ với key thật, rồi sửa các lỗi phát sinh. Chạy `studio script` trước, sau đó `studio build`.
2. Điền model tham chiếu Higgsfield, rồi kiểm tra nhân vật Pip có đồng nhất qua 14 cảnh không.
3. Tạo ảnh nhân vật chuẩn và đặt vào `images.character_reference`.
4. Phiên bản Shorts 9:16 từ cùng kịch bản (thêm composition thứ hai trong Remotion).
5. Hiệu ứng âm thanh theo cảnh: thêm trường `sfx` vào `Scene`, dùng ElevenLabs Sound Effects.
6. Chuyển một số cảnh quan trọng thành clip động bằng image-to-video của Higgsfield.
7. Tuỳ chọn phụ đề/giọng tiếng Việt: hiện đã hỗ trợ qua config (`channel.language`, giọng `vi-VN-...`), font Inter đã gồm subset vietnamese.

## Test trong sandbox cloud (Claude Code on the web)

```bash
cd AIVideoStudio
python3 -m venv /tmp/venv && /tmp/venv/bin/pip install -e .
(cd remotion && npm install && npx tsc --noEmit)
mkdir -p output/test && cp examples/power-outage.json output/test/script.json
# Phải dùng Chromium đầy đủ: chrome-headless-shell không tin CA của proxy nên lỗi tải Google Fonts
export REMOTION_BROWSER_EXECUTABLE=/opt/pw-browsers/chromium-1243/chrome-linux64/chrome
/tmp/venv/bin/studio build output/test --images placeholder --voice silent --renderer remotion
/tmp/venv/bin/studio build output/test --renderer ffmpeg   # kiểm tra renderer dự phòng
```

Sandbox chặn youtube.com, docs.higgsfield.ai và speech.platform.bing.com. Được phép truy cập: npm, pypi, fonts.gstatic.com.
Remotion dựng video 42 giây mất khoảng 3 phút trong sandbox.

## Lịch sử quyết định

- **ffmpeg thay vì MoviePy:** nhanh và ổn định hơn.
- **Thêm Remotion theo yêu cầu người dùng**, kết hợp với Python thay vì thay thế: Python lo phần AI, Remotion lo phần hình. Giữ ffmpeg làm dự phòng.
- **Higgsfield làm provider ảnh mặc định** theo yêu cầu người dùng. Gemini và OpenAI vẫn giữ làm lựa chọn khác.
- **Upload YouTube mặc định `private`** để người dùng duyệt trước. Luôn khai báo nội dung tạo bằng AI.
- **Nhắc người dùng về chính sách YouTube** với nội dung "hàng loạt, lặp lại": nên đọc và sửa kịch bản trước khi dựng, và kiểm tra các con số an toàn (`sources` được tự động thêm vào mô tả video).
