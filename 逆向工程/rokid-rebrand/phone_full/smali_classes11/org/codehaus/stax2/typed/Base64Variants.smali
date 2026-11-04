.class public final Lorg/codehaus/stax2/typed/Base64Variants;
.super Ljava/lang/Object;
.source "Base64Variants.java"


# static fields
.field public static final MIME:Lorg/codehaus/stax2/typed/Base64Variant;

.field public static final MIME_NO_LINEFEEDS:Lorg/codehaus/stax2/typed/Base64Variant;

.field public static final MODIFIED_FOR_URL:Lorg/codehaus/stax2/typed/Base64Variant;

.field public static final PEM:Lorg/codehaus/stax2/typed/Base64Variant;

.field static final STD_BASE64_ALPHABET:Ljava/lang/String; = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"


# direct methods
.method static constructor <clinit>()V
    .locals 10

    .line 36
    new-instance v6, Lorg/codehaus/stax2/typed/Base64Variant;

    const/16 v4, 0x3d

    const/16 v5, 0x4c

    const-string v1, "MIME"

    const-string v2, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

    const/4 v3, 0x1

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/typed/Base64Variant;-><init>(Ljava/lang/String;Ljava/lang/String;ZCI)V

    sput-object v6, Lorg/codehaus/stax2/typed/Base64Variants;->MIME:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 47
    new-instance v0, Lorg/codehaus/stax2/typed/Base64Variant;

    sget-object v1, Lorg/codehaus/stax2/typed/Base64Variants;->MIME:Lorg/codehaus/stax2/typed/Base64Variant;

    const-string v2, "MIME-NO-LINEFEEDS"

    const v3, 0x7fffffff

    invoke-direct {v0, v1, v2, v3}, Lorg/codehaus/stax2/typed/Base64Variant;-><init>(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;I)V

    sput-object v0, Lorg/codehaus/stax2/typed/Base64Variants;->MIME_NO_LINEFEEDS:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 54
    new-instance v0, Lorg/codehaus/stax2/typed/Base64Variant;

    sget-object v5, Lorg/codehaus/stax2/typed/Base64Variants;->MIME:Lorg/codehaus/stax2/typed/Base64Variant;

    const/16 v8, 0x3d

    const/16 v9, 0x40

    const-string v6, "PEM"

    const/4 v7, 0x1

    move-object v4, v0

    invoke-direct/range {v4 .. v9}, Lorg/codehaus/stax2/typed/Base64Variant;-><init>(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;ZCI)V

    sput-object v0, Lorg/codehaus/stax2/typed/Base64Variants;->PEM:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 69
    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 71
    .local v0, "sb":Ljava/lang/StringBuffer;
    const-string v1, "+"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v2, 0x2d

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuffer;->setCharAt(IC)V

    .line 72
    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v2, 0x5f

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuffer;->setCharAt(IC)V

    .line 76
    new-instance v1, Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const v8, 0x7fffffff

    const-string v4, "MODIFIED-FOR-URL"

    const/4 v6, 0x0

    move-object v3, v1

    invoke-direct/range {v3 .. v8}, Lorg/codehaus/stax2/typed/Base64Variant;-><init>(Ljava/lang/String;Ljava/lang/String;ZCI)V

    sput-object v1, Lorg/codehaus/stax2/typed/Base64Variants;->MODIFIED_FOR_URL:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 77
    .end local v0    # "sb":Ljava/lang/StringBuffer;
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;
    .locals 1

    .line 84
    sget-object v0, Lorg/codehaus/stax2/typed/Base64Variants;->MIME:Lorg/codehaus/stax2/typed/Base64Variant;

    return-object v0
.end method
