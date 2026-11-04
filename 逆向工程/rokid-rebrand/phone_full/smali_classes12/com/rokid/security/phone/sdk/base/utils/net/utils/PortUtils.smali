.class public final Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;
.super Ljava/lang/Object;
.source "PortUtils.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nPortUtils.kt\nKotlin\n*S Kotlin\n*F\n+ 1 PortUtils.kt\ncom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils\n+ 2 _Strings.kt\nkotlin/text/StringsKt___StringsKt\n*L\n1#1,31:1\n1174#2,2:32\n*S KotlinDebug\n*F\n+ 1 PortUtils.kt\ncom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils\n*L\n17#1:32,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;",
        "",
        "()V",
        "stringToPort",
        "",
        "str",
        "",
        "base-utils_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/PortUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final stringToPort(Ljava/lang/String;)I
    .locals 12
    .param p1, "str"    # Ljava/lang/String;

    const-string/jumbo v0, "str"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    const-wide/16 v0, 0x0

    .local v0, "hash":J
    const-wide v0, -0x340d631b7bdddcdbL    # -7.302176725335867E57

    .line 15
    const-wide v2, 0x100000001b3L

    .line 17
    .local v2, "fnvPrime":J
    move-object v4, p1

    check-cast v4, Ljava/lang/CharSequence;

    .local v4, "$this$forEach$iv":Ljava/lang/CharSequence;
    const/4 v5, 0x0

    .line 32
    .local v5, "$i$f$forEach":I
    const/4 v6, 0x0

    :goto_0
    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-ge v6, v7, :cond_0

    invoke-interface {v4, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    .local v7, "element$iv":C
    move v8, v7

    .local v8, "char":C
    const/4 v9, 0x0

    .line 18
    .local v9, "$i$a$-forEach-PortUtils$stringToPort$1":I
    int-to-long v10, v8

    xor-long/2addr v0, v10

    .line 19
    mul-long/2addr v0, v2

    .line 20
    nop

    .line 32
    .end local v8    # "char":C
    .end local v9    # "$i$a$-forEach-PortUtils$stringToPort$1":I
    nop

    .end local v7    # "element$iv":C
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 33
    :cond_0
    nop

    .line 23
    .end local v4    # "$this$forEach$iv":Ljava/lang/CharSequence;
    .end local v5    # "$i$f$forEach":I
    const-wide v4, 0x7fffffffffffffffL

    and-long/2addr v4, v0

    long-to-int v4, v4

    .line 26
    .local v4, "positiveHash":I
    const/16 v5, 0xbb8

    .line 27
    .local v5, "minPort":I
    const v6, 0xfde8

    .line 28
    .local v6, "maxPort":I
    sub-int v7, v6, v5

    add-int/lit8 v7, v7, 0x1

    .line 29
    .local v7, "portRange":I
    rem-int v8, v4, v7

    add-int/2addr v8, v5

    return v8
.end method
