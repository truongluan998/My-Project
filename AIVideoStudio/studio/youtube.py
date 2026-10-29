from __future__ import annotations

from pathlib import Path

from .config import ROOT, Config
from .models import Episode

SCOPES = ["https://www.googleapis.com/auth/youtube.upload"]
TOKEN = ROOT / "youtube_token.json"
CLIENT_SECRET = ROOT / "client_secret.json"


def _service():
    from google.auth.transport.requests import Request
    from google.oauth2.credentials import Credentials
    from google_auth_oauthlib.flow import InstalledAppFlow
    from googleapiclient.discovery import build

    creds = Credentials.from_authorized_user_file(str(TOKEN), SCOPES) if TOKEN.exists() else None
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not CLIENT_SECRET.exists():
                raise SystemExit("Thiếu client_secret.json (OAuth Desktop app từ Google Cloud Console). Xem README.")
            creds = InstalledAppFlow.from_client_secrets_file(str(CLIENT_SECRET), SCOPES).run_local_server(port=0)
        TOKEN.write_text(creds.to_json(), encoding="utf-8")
    return build("youtube", "v3", credentials=creds)


def upload(cfg: Config, episode: Episode, video: Path, thumbnail: Path | None, privacy: str | None = None) -> str:
    from googleapiclient.http import MediaFileUpload

    yt = _service()
    description = episode.description
    if episode.sources:
        description += "\n\nSources:\n" + "\n".join(f"- {s}" for s in episode.sources)
    body = {
        "snippet": {
            "title": episode.title[:100],
            "description": description[:5000],
            "tags": episode.tags,
            "categoryId": cfg.youtube.category_id,
        },
        "status": {
            "privacyStatus": privacy or cfg.youtube.privacy,
            "selfDeclaredMadeForKids": cfg.youtube.made_for_kids,
            # Declare AI-generated media, as YouTube's policy requires for altered/synthetic content.
            "containsSyntheticMedia": True,
        },
    }
    request = yt.videos().insert(part="snippet,status", body=body,
                                 media_body=MediaFileUpload(str(video), chunksize=-1, resumable=True))
    response = None
    while response is None:
        _, response = request.next_chunk()
    video_id = response["id"]
    if thumbnail:
        # Custom thumbnails require a phone-verified channel; the upload itself still succeeds without it.
        try:
            yt.thumbnails().set(videoId=video_id, media_body=MediaFileUpload(str(thumbnail))).execute()
        except Exception as e:  # noqa: BLE001
            print(f"Không đặt được thumbnail (kênh cần xác minh số điện thoại?): {e}")
    return f"https://youtu.be/{video_id}"
