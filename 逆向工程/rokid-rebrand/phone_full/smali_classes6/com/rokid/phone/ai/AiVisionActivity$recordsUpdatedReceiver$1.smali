.class public final Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;
.super Landroid/content/BroadcastReceiver;
.source "AiVisionActivity.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ai/AiVisionActivity;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u001c\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u0007H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1",
        "Landroid/content/BroadcastReceiver;",
        "onReceive",
        "",
        "context",
        "Landroid/content/Context;",
        "intent",
        "Landroid/content/Intent;",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/phone/ai/AiVisionActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ai/AiVisionActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/phone/ai/AiVisionActivity;

    iput-object p1, p0, Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    .line 46
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 48
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v0}, Lcom/rokid/phone/ai/AiVisionActivity;->access$loadStoredRecords(Lcom/rokid/phone/ai/AiVisionActivity;)V

    .line 49
    return-void
.end method
