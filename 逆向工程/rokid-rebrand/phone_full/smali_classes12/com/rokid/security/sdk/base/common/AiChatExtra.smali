.class public final Lcom/rokid/security/sdk/base/common/AiChatExtra;
.super Ljava/lang/Object;
.source "AiChatExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\n\u0002\u0010\u000b\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008(\n\u0002\u0010\t\n\u0002\u0008\u0014\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u001c\u0010\u0015\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001a\u0010\u001b\u001a\u00020\u001cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001d\u0010\u001e\"\u0004\u0008\u001f\u0010 R\u001a\u0010!\u001a\u00020\"X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008#\u0010$\"\u0004\u0008%\u0010&R\u001a\u0010\'\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008(\u0010\u0006\"\u0004\u0008)\u0010\u0008R\u001a\u0010*\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008+\u0010\u0006\"\u0004\u0008,\u0010\u0008R\u001a\u0010-\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008.\u0010\u0006\"\u0004\u0008/\u0010\u0008R\u001a\u00100\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00081\u0010\u0006\"\u0004\u00082\u0010\u0008R\u001c\u00103\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00084\u0010\u0006\"\u0004\u00085\u0010\u0008R\u001a\u00106\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00087\u0010\u0006\"\u0004\u00088\u0010\u0008R\u001a\u00109\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008:\u0010\u0006\"\u0004\u0008;\u0010\u0008R\u001a\u0010<\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008<\u0010\u0012\"\u0004\u0008=\u0010\u0014R\u001a\u0010>\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008?\u0010\u0006\"\u0004\u0008@\u0010\u0008R\u001c\u0010A\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008B\u0010\u0006\"\u0004\u0008C\u0010\u0008R\u001a\u0010D\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008E\u0010\u0006\"\u0004\u0008F\u0010\u0008R\u001c\u0010G\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008H\u0010\u0006\"\u0004\u0008I\u0010\u0008R\u001a\u0010J\u001a\u00020KX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008L\u0010M\"\u0004\u0008N\u0010OR\u001c\u0010P\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008Q\u0010\u0006\"\u0004\u0008R\u0010\u0008R\u001c\u0010S\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008T\u0010\u0006\"\u0004\u0008U\u0010\u0008R\u001c\u0010V\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008W\u0010\u0006\"\u0004\u0008X\u0010\u0008R\u001a\u0010Y\u001a\u00020\u0010X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008Z\u0010\u0012\"\u0004\u0008[\u0010\u0014R\u001c\u0010\\\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008]\u0010\u0006\"\u0004\u0008^\u0010\u0008\u00a8\u0006_"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "",
        "()V",
        "OfflineTaskID",
        "",
        "getOfflineTaskID",
        "()Ljava/lang/String;",
        "setOfflineTaskID",
        "(Ljava/lang/String;)V",
        "aiImageType",
        "getAiImageType",
        "setAiImageType",
        "answer",
        "getAnswer",
        "setAnswer",
        "answerIsFinish",
        "",
        "getAnswerIsFinish",
        "()Z",
        "setAnswerIsFinish",
        "(Z)V",
        "audioSessionId",
        "getAudioSessionId",
        "setAudioSessionId",
        "chatStreamVersion",
        "getChatStreamVersion",
        "setChatStreamVersion",
        "contentType",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        "getContentType",
        "()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        "setContentType",
        "(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V",
        "errCode",
        "",
        "getErrCode",
        "()I",
        "setErrCode",
        "(I)V",
        "filePath",
        "getFilePath",
        "setFilePath",
        "imageBase64",
        "getImageBase64",
        "setImageBase64",
        "imageId",
        "getImageId",
        "setImageId",
        "imagePath",
        "getImagePath",
        "setImagePath",
        "imageStreamTag",
        "getImageStreamTag",
        "setImageStreamTag",
        "imageUrl",
        "getImageUrl",
        "setImageUrl",
        "intent",
        "getIntent",
        "setIntent",
        "isNormal",
        "setNormal",
        "methodName",
        "getMethodName",
        "setMethodName",
        "mirrorSeq",
        "getMirrorSeq",
        "setMirrorSeq",
        "question",
        "getQuestion",
        "setQuestion",
        "questionId",
        "getQuestionId",
        "setQuestionId",
        "recordEndTime",
        "",
        "getRecordEndTime",
        "()J",
        "setRecordEndTime",
        "(J)V",
        "sessionId",
        "getSessionId",
        "setSessionId",
        "source",
        "getSource",
        "setSource",
        "textSessionId",
        "getTextSessionId",
        "setTextSessionId",
        "useBase64Image",
        "getUseBase64Image",
        "setUseBase64Image",
        "videoFileMD5",
        "getVideoFileMD5",
        "setVideoFileMD5",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private OfflineTaskID:Ljava/lang/String;

.field private aiImageType:Ljava/lang/String;

.field private answer:Ljava/lang/String;

.field private answerIsFinish:Z

.field private audioSessionId:Ljava/lang/String;

.field private chatStreamVersion:Ljava/lang/String;

.field private contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

.field private errCode:I

.field private filePath:Ljava/lang/String;

.field private imageBase64:Ljava/lang/String;

.field private imageId:Ljava/lang/String;

.field private imagePath:Ljava/lang/String;

.field private imageStreamTag:Ljava/lang/String;

.field private imageUrl:Ljava/lang/String;

.field private intent:Ljava/lang/String;

.field private isNormal:Z

.field private methodName:Ljava/lang/String;

.field private mirrorSeq:Ljava/lang/String;

.field private question:Ljava/lang/String;

.field private questionId:Ljava/lang/String;

.field private recordEndTime:J

.field private sessionId:Ljava/lang/String;

.field private source:Ljava/lang/String;

.field private textSessionId:Ljava/lang/String;

.field private useBase64Image:Z

.field private videoFileMD5:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->methodName:Ljava/lang/String;

    .line 24
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->question:Ljava/lang/String;

    .line 25
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageUrl:Ljava/lang/String;

    .line 26
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageId:Ljava/lang/String;

    .line 27
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->filePath:Ljava/lang/String;

    .line 28
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->useBase64Image:Z

    .line 29
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imagePath:Ljava/lang/String;

    .line 30
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageBase64:Ljava/lang/String;

    .line 33
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->intent:Ljava/lang/String;

    .line 34
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->answer:Ljava/lang/String;

    .line 37
    sget-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->AUDIO:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    .line 52
    const-string v0, "jpg"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->aiImageType:Ljava/lang/String;

    .line 54
    const-string/jumbo v0, "v1"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->chatStreamVersion:Ljava/lang/String;

    .line 16
    return-void
.end method


# virtual methods
.method public final getAiImageType()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->aiImageType:Ljava/lang/String;

    return-object v0
.end method

.method public final getAnswer()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->answer:Ljava/lang/String;

    return-object v0
.end method

.method public final getAnswerIsFinish()Z
    .locals 1

    .line 35
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->answerIsFinish:Z

    return v0
.end method

.method public final getAudioSessionId()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->audioSessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getChatStreamVersion()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->chatStreamVersion:Ljava/lang/String;

    return-object v0
.end method

.method public final getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-object v0
.end method

.method public final getErrCode()I
    .locals 1

    .line 22
    iget v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->errCode:I

    return v0
.end method

.method public final getFilePath()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageBase64()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageId()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageId:Ljava/lang/String;

    return-object v0
.end method

.method public final getImagePath()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imagePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageStreamTag()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageStreamTag:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageUrl()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getIntent()Ljava/lang/String;
    .locals 1

    .line 33
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->intent:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getMirrorSeq()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->mirrorSeq:Ljava/lang/String;

    return-object v0
.end method

.method public final getOfflineTaskID()Ljava/lang/String;
    .locals 1

    .line 49
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->OfflineTaskID:Ljava/lang/String;

    return-object v0
.end method

.method public final getQuestion()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->question:Ljava/lang/String;

    return-object v0
.end method

.method public final getQuestionId()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->questionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getRecordEndTime()J
    .locals 2

    .line 45
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->recordEndTime:J

    return-wide v0
.end method

.method public final getSessionId()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSource()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->source:Ljava/lang/String;

    return-object v0
.end method

.method public final getTextSessionId()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->textSessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getUseBase64Image()Z
    .locals 1

    .line 28
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->useBase64Image:Z

    return v0
.end method

.method public final getVideoFileMD5()Ljava/lang/String;
    .locals 1

    .line 46
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->videoFileMD5:Ljava/lang/String;

    return-object v0
.end method

.method public final isNormal()Z
    .locals 1

    .line 50
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->isNormal:Z

    return v0
.end method

.method public final setAiImageType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->aiImageType:Ljava/lang/String;

    return-void
.end method

.method public final setAnswer(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->answer:Ljava/lang/String;

    return-void
.end method

.method public final setAnswerIsFinish(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 35
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->answerIsFinish:Z

    return-void
.end method

.method public final setAudioSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 39
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->audioSessionId:Ljava/lang/String;

    return-void
.end method

.method public final setChatStreamVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 54
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->chatStreamVersion:Ljava/lang/String;

    return-void
.end method

.method public final setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->contentType:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-void
.end method

.method public final setErrCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 22
    iput p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->errCode:I

    return-void
.end method

.method public final setFilePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->filePath:Ljava/lang/String;

    return-void
.end method

.method public final setImageBase64(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageBase64:Ljava/lang/String;

    return-void
.end method

.method public final setImageId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageId:Ljava/lang/String;

    return-void
.end method

.method public final setImagePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imagePath:Ljava/lang/String;

    return-void
.end method

.method public final setImageStreamTag(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 44
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageStreamTag:Ljava/lang/String;

    return-void
.end method

.method public final setImageUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->imageUrl:Ljava/lang/String;

    return-void
.end method

.method public final setIntent(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->intent:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setMirrorSeq(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 43
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->mirrorSeq:Ljava/lang/String;

    return-void
.end method

.method public final setNormal(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 50
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->isNormal:Z

    return-void
.end method

.method public final setOfflineTaskID(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 49
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->OfflineTaskID:Ljava/lang/String;

    return-void
.end method

.method public final setQuestion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->question:Ljava/lang/String;

    return-void
.end method

.method public final setQuestionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 41
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->questionId:Ljava/lang/String;

    return-void
.end method

.method public final setRecordEndTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 45
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->recordEndTime:J

    return-void
.end method

.method public final setSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 38
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->sessionId:Ljava/lang/String;

    return-void
.end method

.method public final setSource(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 42
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->source:Ljava/lang/String;

    return-void
.end method

.method public final setTextSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 40
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->textSessionId:Ljava/lang/String;

    return-void
.end method

.method public final setUseBase64Image(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 28
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->useBase64Image:Z

    return-void
.end method

.method public final setVideoFileMD5(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 46
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/AiChatExtra;->videoFileMD5:Ljava/lang/String;

    return-void
.end method
