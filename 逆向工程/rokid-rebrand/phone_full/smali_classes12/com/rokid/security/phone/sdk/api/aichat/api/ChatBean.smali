.class public final Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;
.super Ljava/lang/Object;
.source "ChatBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000e\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\t\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001c\u0010\u000c\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001c\u0010\u000f\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0013X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015\"\u0004\u0008\u0016\u0010\u0017R\u001a\u0010\u0018\u001a\u00020\u0019X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001a\u0010\u001b\"\u0004\u0008\u001c\u0010\u001d\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
        "",
        "()V",
        "answer",
        "",
        "getAnswer",
        "()Ljava/lang/String;",
        "setAnswer",
        "(Ljava/lang/String;)V",
        "imageUrl",
        "getImageUrl",
        "setImageUrl",
        "question",
        "getQuestion",
        "setQuestion",
        "questionId",
        "getQuestionId",
        "setQuestionId",
        "sourceType",
        "",
        "getSourceType",
        "()I",
        "setSourceType",
        "(I)V",
        "time",
        "",
        "getTime",
        "()J",
        "setTime",
        "(J)V",
        "sdk-api_release"
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
.field private answer:Ljava/lang/String;

.field private imageUrl:Ljava/lang/String;

.field private question:Ljava/lang/String;

.field private questionId:Ljava/lang/String;

.field private sourceType:I

.field private time:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getAnswer()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->answer:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageUrl()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->imageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getQuestion()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->question:Ljava/lang/String;

    return-object v0
.end method

.method public final getQuestionId()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->questionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSourceType()I
    .locals 1

    .line 14
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->sourceType:I

    return v0
.end method

.method public final getTime()J
    .locals 2

    .line 16
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->time:J

    return-wide v0
.end method

.method public final setAnswer(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 13
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->answer:Ljava/lang/String;

    return-void
.end method

.method public final setImageUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 11
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->imageUrl:Ljava/lang/String;

    return-void
.end method

.method public final setQuestion(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 10
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->question:Ljava/lang/String;

    return-void
.end method

.method public final setQuestionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 9
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->questionId:Ljava/lang/String;

    return-void
.end method

.method public final setSourceType(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 14
    iput p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->sourceType:I

    return-void
.end method

.method public final setTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 16
    iput-wide p1, p0, Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;->time:J

    return-void
.end method
