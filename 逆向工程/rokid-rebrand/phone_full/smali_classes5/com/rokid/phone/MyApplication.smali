.class public final Lcom/rokid/phone/MyApplication;
.super Landroid/app/Application;
.source "MyApplication.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/MyApplication$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0018\u0000 \u00062\u00020\u0001:\u0001\u0006B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0008\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/phone/MyApplication;",
        "Landroid/app/Application;",
        "<init>",
        "()V",
        "onCreate",
        "",
        "Companion",
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


# static fields
.field public static final Companion:Lcom/rokid/phone/MyApplication$Companion;

.field public static final MainAppClientId:Ljava/lang/String; = "RokidESecurity"

.field public static instance:Lcom/rokid/phone/MyApplication;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/phone/MyApplication$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/phone/MyApplication$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/phone/MyApplication;->Companion:Lcom/rokid/phone/MyApplication$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 1

    .line 12
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 13
    sget-object v0, Lcom/rokid/phone/MyApplication;->Companion:Lcom/rokid/phone/MyApplication$Companion;

    invoke-virtual {v0, p0}, Lcom/rokid/phone/MyApplication$Companion;->setInstance(Lcom/rokid/phone/MyApplication;)V

    .line 14
    return-void
.end method
