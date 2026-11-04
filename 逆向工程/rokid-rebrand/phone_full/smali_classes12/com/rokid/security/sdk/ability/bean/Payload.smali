.class public final Lcom/rokid/security/sdk/ability/bean/Payload;
.super Ljava/lang/Object;
.source "VekWsResponse.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u001a\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u000c\"\u0004\u0008\u0014\u0010\u000eR\u001a\u0010\u0015\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u000c\"\u0004\u0008\u0017\u0010\u000eR\u001a\u0010\u0018\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u000c\"\u0004\u0008\u001a\u0010\u000eR\u001a\u0010\u001b\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u000c\"\u0004\u0008\u001d\u0010\u000eR\u001a\u0010\u001e\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u000c\"\u0004\u0008 \u0010\u000eR\u001a\u0010!\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\"\u0010\u000c\"\u0004\u0008#\u0010\u000e\u00a8\u0006$"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/bean/Payload;",
        "",
        "()V",
        "definite",
        "",
        "getDefinite",
        "()Z",
        "setDefinite",
        "(Z)V",
        "from",
        "",
        "getFrom",
        "()Ljava/lang/String;",
        "setFrom",
        "(Ljava/lang/String;)V",
        "hasFinal",
        "getHasFinal",
        "setHasFinal",
        "joinRoomName",
        "getJoinRoomName",
        "setJoinRoomName",
        "joinToken",
        "getJoinToken",
        "setJoinToken",
        "joinUrl",
        "getJoinUrl",
        "setJoinUrl",
        "meetingId",
        "getMeetingId",
        "setMeetingId",
        "meetingName",
        "getMeetingName",
        "setMeetingName",
        "text",
        "getText",
        "setText",
        "sdk-common-ability_release"
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
.field private definite:Z

.field private from:Ljava/lang/String;

.field private hasFinal:Z

.field private joinRoomName:Ljava/lang/String;

.field private joinToken:Ljava/lang/String;

.field private joinUrl:Ljava/lang/String;

.field private meetingId:Ljava/lang/String;

.field private meetingName:Ljava/lang/String;

.field private text:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->text:Ljava/lang/String;

    .line 35
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->from:Ljava/lang/String;

    .line 36
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingId:Ljava/lang/String;

    .line 37
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinUrl:Ljava/lang/String;

    .line 38
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinToken:Ljava/lang/String;

    .line 39
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingName:Ljava/lang/String;

    .line 40
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinRoomName:Ljava/lang/String;

    .line 28
    return-void
.end method


# virtual methods
.method public final getDefinite()Z
    .locals 1

    .line 33
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->definite:Z

    return v0
.end method

.method public final getFrom()Ljava/lang/String;
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->from:Ljava/lang/String;

    return-object v0
.end method

.method public final getHasFinal()Z
    .locals 1

    .line 31
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->hasFinal:Z

    return v0
.end method

.method public final getJoinRoomName()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinRoomName:Ljava/lang/String;

    return-object v0
.end method

.method public final getJoinToken()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinToken:Ljava/lang/String;

    return-object v0
.end method

.method public final getJoinUrl()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getMeetingId()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMeetingName()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingName:Ljava/lang/String;

    return-object v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final setDefinite(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 33
    iput-boolean p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->definite:Z

    return-void
.end method

.method public final setFrom(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->from:Ljava/lang/String;

    return-void
.end method

.method public final setHasFinal(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 31
    iput-boolean p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->hasFinal:Z

    return-void
.end method

.method public final setJoinRoomName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinRoomName:Ljava/lang/String;

    return-void
.end method

.method public final setJoinToken(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinToken:Ljava/lang/String;

    return-void
.end method

.method public final setJoinUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->joinUrl:Ljava/lang/String;

    return-void
.end method

.method public final setMeetingId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingId:Ljava/lang/String;

    return-void
.end method

.method public final setMeetingName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->meetingName:Ljava/lang/String;

    return-void
.end method

.method public final setText(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/Payload;->text:Ljava/lang/String;

    return-void
.end method
