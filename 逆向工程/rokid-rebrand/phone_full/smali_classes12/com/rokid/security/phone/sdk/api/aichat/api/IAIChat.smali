.class public interface abstract Lcom/rokid/security/phone/sdk/api/aichat/api/IAIChat;
.super Ljava/lang/Object;
.source "IAIChat.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u000e\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H&J\u0008\u0010\u0005\u001a\u00020\u0006H&J\u0010\u0010\u0007\u001a\u00020\u00062\u0006\u0010\u0008\u001a\u00020\tH&J\u0010\u0010\n\u001a\u00020\u00062\u0006\u0010\u000b\u001a\u00020\u000cH&\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/aichat/api/IAIChat;",
        "",
        "getRunTimeChatList",
        "",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
        "removeAiChatListener",
        "",
        "setAiChatListener",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;",
        "toChat",
        "question",
        "",
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


# virtual methods
.method public abstract getRunTimeChatList()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/aichat/api/ChatBean;",
            ">;"
        }
    .end annotation
.end method

.method public abstract removeAiChatListener()V
.end method

.method public abstract setAiChatListener(Lcom/rokid/security/phone/sdk/api/aichat/api/AiChatListener;)V
.end method

.method public abstract toChat(Ljava/lang/String;)V
.end method
