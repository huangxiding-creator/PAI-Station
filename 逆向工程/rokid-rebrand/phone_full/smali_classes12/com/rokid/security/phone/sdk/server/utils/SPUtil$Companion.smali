.class public final Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;
.super Ljava/lang/Object;
.source "SPUtil.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSPUtil.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SPUtil.kt\ncom/rokid/security/phone/sdk/server/utils/SPUtil$Companion\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,193:1\n1#2:194\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0008\u001a\u00020\u00072\u0006\u0010\t\u001a\u00020\nR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;",
        "",
        "()V",
        "KEY_APPS_LIST",
        "",
        "SP_NAME",
        "instance",
        "Lcom/rokid/security/phone/sdk/server/utils/SPUtil;",
        "getInstance",
        "context",
        "Landroid/content/Context;",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final getInstance(Landroid/content/Context;)Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->access$getInstance$cp()Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    move-result-object v0

    if-nez v0, :cond_1

    monitor-enter p0

    const/4 v0, 0x0

    .line 27
    .local v0, "$i$a$-synchronized-SPUtil$Companion$getInstance$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->access$getInstance$cp()Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    move-result-object v1

    if-nez v1, :cond_0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "context.applicationContext"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;-><init>(Landroid/content/Context;Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    move-object v2, v1

    .line 194
    .local v2, "it":Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
    const/4 v3, 0x0

    .line 27
    .local v3, "$i$a$-also-SPUtil$Companion$getInstance$1$1":I
    sget-object v4, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->Companion:Lcom/rokid/security/phone/sdk/server/utils/SPUtil$Companion;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/utils/SPUtil;->access$setInstance$cp(Lcom/rokid/security/phone/sdk/server/utils/SPUtil;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 26
    .end local v0    # "$i$a$-synchronized-SPUtil$Companion$getInstance$1":I
    .end local v2    # "it":Lcom/rokid/security/phone/sdk/server/utils/SPUtil;
    .end local v3    # "$i$a$-also-SPUtil$Companion$getInstance$1$1":I
    :cond_0
    monitor-exit p0

    move-object v0, v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0

    :cond_1
    :goto_0
    return-object v0
.end method
