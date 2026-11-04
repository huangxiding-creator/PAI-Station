.class public final Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;
.super Ljava/lang/Object;
.source "ResumableFileTransferPolicy.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nResumableFileTransferPolicy.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ResumableFileTransferPolicy.kt\ncom/rokid/security/sdk/base/common/ResumableFileTransferPolicy\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,14:1\n1#2:15\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u0004J\u0016\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000c2\u0006\u0010\u000e\u001a\u00020\u000cR\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;",
        "",
        "()V",
        "DIRECTORY_PREFIX",
        "",
        "HANDSHAKE_MAGIC",
        "",
        "HANDSHAKE_TIMEOUT_MS",
        "isResumablePath",
        "",
        "wirePath",
        "validOffset",
        "",
        "candidate",
        "totalBytes",
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


# static fields
.field public static final DIRECTORY_PREFIX:Ljava/lang/String; = "_ota_resume_v1/"

.field public static final HANDSHAKE_MAGIC:I = 0x4f544131

.field public static final HANDSHAKE_TIMEOUT_MS:I = 0x7d0

.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;->INSTANCE:Lcom/rokid/security/sdk/base/common/ResumableFileTransferPolicy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isResumablePath(Ljava/lang/String;)Z
    .locals 4
    .param p1, "wirePath"    # Ljava/lang/String;

    const-string/jumbo v0, "wirePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    const/4 v0, 0x2

    const/4 v1, 0x0

    const-string v2, "_ota_resume_v1/"

    const/4 v3, 0x0

    invoke-static {p1, v2, v3, v0, v1}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final validOffset(JJ)J
    .locals 8
    .param p1, "candidate"    # J
    .param p3, "totalBytes"    # J

    .line 12
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v1

    .line 15
    .local v1, "it":J
    const/4 v3, 0x0

    .line 12
    .local v3, "$i$a$-takeIf-ResumableFileTransferPolicy$validOffset$1":I
    const-wide/16 v4, 0x0

    cmp-long v6, v4, v1

    const/4 v7, 0x0

    if-gtz v6, :cond_0

    cmp-long v6, v1, p3

    if-gtz v6, :cond_0

    const/4 v7, 0x1

    .end local v1    # "it":J
    .end local v3    # "$i$a$-takeIf-ResumableFileTransferPolicy$validOffset$1":I
    :cond_0
    if-eqz v7, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    :cond_2
    return-wide v4
.end method
