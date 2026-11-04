.class public final Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;
.super Ljava/lang/Object;
.source "DataUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;",
        "",
        "()V",
        "METADATA_DELIMITER",
        "",
        "METADATA_END_MARKER",
        "findEndMarkerIndex",
        "",
        "data",
        "",
        "startIndex",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

.field public static final METADATA_DELIMITER:Ljava/lang/String; = "\u0001"

.field public static final METADATA_END_MARKER:Ljava/lang/String; = "\\u2063\\u2064\\u2065"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final findEndMarkerIndex([BI)I
    .locals 8
    .param p1, "data"    # [B
    .param p2, "startIndex"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    const-string v0, "\\u2063\\u2064\\u2065"

    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    const-string v1, "this as java.lang.String).getBytes(charset)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    .local v0, "endMarkerBytes":[B
    move v1, p2

    .local v1, "i":I
    array-length v2, p1

    array-length v3, v0

    sub-int/2addr v2, v3

    add-int/lit8 v2, v2, 0x1

    :goto_0
    if-ge v1, v2, :cond_3

    .line 17
    const/4 v3, 0x1

    .line 18
    .local v3, "match":Z
    const/4 v4, 0x0

    .local v4, "j":I
    array-length v5, v0

    :goto_1
    if-ge v4, v5, :cond_1

    .line 19
    add-int v6, v1, v4

    aget-byte v6, p1, v6

    aget-byte v7, v0, v4

    if-eq v6, v7, :cond_0

    .line 20
    const/4 v3, 0x0

    .line 21
    goto :goto_2

    .line 18
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 24
    .end local v4    # "j":I
    :cond_1
    :goto_2
    if-eqz v3, :cond_2

    .line 25
    return v1

    .line 16
    .end local v3    # "match":Z
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 28
    .end local v1    # "i":I
    :cond_3
    const/4 v1, -0x1

    return v1
.end method
