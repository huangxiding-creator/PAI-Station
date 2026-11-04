.class public final Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;
.super Ljava/lang/Object;
.source "VoiceSettingValueParser.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nVoiceSettingValueParser.kt\nKotlin\n*S Kotlin\n*F\n+ 1 VoiceSettingValueParser.kt\ncom/rokid/security/sdk/ability/asr/VoiceSettingValueParser\n+ 2 _Strings.kt\nkotlin/text/StringsKt___StringsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,80:1\n1174#2,2:81\n1083#2,2:84\n1174#2,2:86\n1174#2,2:88\n1#3:83\n*S KotlinDebug\n*F\n+ 1 VoiceSettingValueParser.kt\ncom/rokid/security/sdk/ability/asr/VoiceSettingValueParser\n*L\n32#1:81,2\n38#1:84,2\n41#1:86,2\n50#1:88,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000c\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0017\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u0007\u001a\u00020\u0008H\u0002\u00a2\u0006\u0002\u0010\tJ\u0010\u0010\n\u001a\u0004\u0018\u00010\u000b2\u0006\u0010\u000c\u001a\u00020\rJ\u0017\u0010\u000e\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u000f\u001a\u00020\rH\u0002\u00a2\u0006\u0002\u0010\u0010R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;",
        "",
        "()V",
        "numberPattern",
        "Lkotlin/text/Regex;",
        "chineseDigit",
        "",
        "char",
        "",
        "(C)Ljava/lang/Integer;",
        "parse",
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;",
        "text",
        "",
        "parseNumber",
        "token",
        "(Ljava/lang/String;)Ljava/lang/Integer;",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

.field private static final numberPattern:Lkotlin/text/Regex;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

    .line 15
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "[0-9\uff10-\uff19]+|[\u96f6\u3007\u25cb\u4e00\u4e8c\u4e24\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u5341\u767e\u58f9\u8d30\u53c1\u8086\u4f0d\u9646\u67d2\u634c\u7396\u62fe\u4f70]+"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->numberPattern:Lkotlin/text/Regex;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final chineseDigit(C)Ljava/lang/Integer;
    .locals 3
    .param p1, "char"    # C

    .line 66
    nop

    .line 67
    const v0, 0x96f6

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ne p1, v0, :cond_0

    :goto_0
    move v0, v2

    goto :goto_1

    :cond_0
    const/16 v0, 0x3007

    if-ne p1, v0, :cond_1

    goto :goto_0

    :cond_1
    move v0, v1

    :goto_1
    if-eqz v0, :cond_2

    :goto_2
    move v0, v2

    goto :goto_3

    :cond_2
    const/16 v0, 0x25cb

    if-ne p1, v0, :cond_3

    goto :goto_2

    :cond_3
    move v0, v1

    :goto_3
    if-eqz v0, :cond_4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 68
    :cond_4
    const/16 v0, 0x4e00

    if-ne p1, v0, :cond_5

    :goto_4
    move v0, v2

    goto :goto_5

    :cond_5
    const/16 v0, 0x58f9

    if-ne p1, v0, :cond_6

    goto :goto_4

    :cond_6
    move v0, v1

    :goto_5
    if-eqz v0, :cond_7

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 69
    :cond_7
    const/16 v0, 0x4e8c

    if-ne p1, v0, :cond_8

    :goto_6
    move v0, v2

    goto :goto_7

    :cond_8
    const/16 v0, 0x4e24

    if-ne p1, v0, :cond_9

    goto :goto_6

    :cond_9
    move v0, v1

    :goto_7
    if-eqz v0, :cond_a

    :goto_8
    move v0, v2

    goto :goto_9

    :cond_a
    const v0, 0x8d30

    if-ne p1, v0, :cond_b

    goto :goto_8

    :cond_b
    move v0, v1

    :goto_9
    if-eqz v0, :cond_c

    const/4 v0, 0x2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 70
    :cond_c
    const/16 v0, 0x4e09

    if-ne p1, v0, :cond_d

    :goto_a
    move v0, v2

    goto :goto_b

    :cond_d
    const/16 v0, 0x53c1

    if-ne p1, v0, :cond_e

    goto :goto_a

    :cond_e
    move v0, v1

    :goto_b
    if-eqz v0, :cond_f

    const/4 v0, 0x3

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 71
    :cond_f
    const/16 v0, 0x56db

    if-ne p1, v0, :cond_10

    :goto_c
    move v0, v2

    goto :goto_d

    :cond_10
    const v0, 0x8086

    if-ne p1, v0, :cond_11

    goto :goto_c

    :cond_11
    move v0, v1

    :goto_d
    if-eqz v0, :cond_12

    const/4 v0, 0x4

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 72
    :cond_12
    const/16 v0, 0x4e94

    if-ne p1, v0, :cond_13

    :goto_e
    move v0, v2

    goto :goto_f

    :cond_13
    const/16 v0, 0x4f0d

    if-ne p1, v0, :cond_14

    goto :goto_e

    :cond_14
    move v0, v1

    :goto_f
    if-eqz v0, :cond_15

    const/4 v0, 0x5

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto/16 :goto_18

    .line 73
    :cond_15
    const/16 v0, 0x516d

    if-ne p1, v0, :cond_16

    :goto_10
    move v0, v2

    goto :goto_11

    :cond_16
    const v0, 0x9646

    if-ne p1, v0, :cond_17

    goto :goto_10

    :cond_17
    move v0, v1

    :goto_11
    if-eqz v0, :cond_18

    const/4 v0, 0x6

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_18

    .line 74
    :cond_18
    const/16 v0, 0x4e03

    if-ne p1, v0, :cond_19

    :goto_12
    move v0, v2

    goto :goto_13

    :cond_19
    const/16 v0, 0x67d2

    if-ne p1, v0, :cond_1a

    goto :goto_12

    :cond_1a
    move v0, v1

    :goto_13
    if-eqz v0, :cond_1b

    const/4 v0, 0x7

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_18

    .line 75
    :cond_1b
    const/16 v0, 0x516b

    if-ne p1, v0, :cond_1c

    :goto_14
    move v0, v2

    goto :goto_15

    :cond_1c
    const/16 v0, 0x634c

    if-ne p1, v0, :cond_1d

    goto :goto_14

    :cond_1d
    move v0, v1

    :goto_15
    if-eqz v0, :cond_1e

    const/16 v0, 0x8

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_18

    .line 76
    :cond_1e
    const/16 v0, 0x4e5d

    if-ne p1, v0, :cond_1f

    :goto_16
    move v1, v2

    goto :goto_17

    :cond_1f
    const/16 v0, 0x7396

    if-ne p1, v0, :cond_20

    goto :goto_16

    :cond_20
    :goto_17
    if-eqz v1, :cond_21

    const/16 v0, 0x9

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_18

    .line 77
    :cond_21
    const/4 v0, 0x0

    .line 78
    :goto_18
    return-object v0
.end method

.method private final parseNumber(Ljava/lang/String;)Ljava/lang/Integer;
    .locals 18
    .param p1, "token"    # Ljava/lang/String;

    .line 31
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(I)V

    move-object v0, v1

    .local v0, "$this$parseNumber_u24lambda_u241":Ljava/lang/StringBuilder;
    const/4 v2, 0x0

    .line 32
    .local v2, "$i$a$-buildString-VoiceSettingValueParser$parseNumber$normalized$1":I
    move-object/from16 v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    .local v3, "$this$forEach$iv":Ljava/lang/CharSequence;
    const/4 v4, 0x0

    .line 81
    .local v4, "$i$f$forEach":I
    const/4 v6, 0x0

    :goto_0
    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v7

    const/4 v8, 0x1

    if-ge v6, v7, :cond_2

    invoke-interface {v3, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    .local v7, "element$iv":C
    move v9, v7

    .local v9, "char":C
    const/4 v10, 0x0

    .line 33
    .local v10, "$i$a$-forEach-VoiceSettingValueParser$parseNumber$normalized$1$1":I
    const v11, 0xff10

    if-gt v11, v9, :cond_0

    const v12, 0xff1a

    if-ge v9, v12, :cond_0

    goto :goto_1

    :cond_0
    const/4 v8, 0x0

    :goto_1
    if-eqz v8, :cond_1

    sub-int v8, v9, v11

    add-int/lit8 v8, v8, 0x30

    int-to-char v8, v8

    goto :goto_2

    :cond_1
    move v8, v9

    :goto_2
    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 34
    nop

    .line 81
    .end local v9    # "char":C
    .end local v10    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$normalized$1$1":I
    nop

    .end local v7    # "element$iv":C
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 82
    :cond_2
    nop

    .line 35
    .end local v3    # "$this$forEach$iv":Ljava/lang/CharSequence;
    .end local v4    # "$i$f$forEach":I
    nop

    .line 31
    .end local v0    # "$this$parseNumber_u24lambda_u241":Ljava/lang/StringBuilder;
    .end local v2    # "$i$a$-buildString-VoiceSettingValueParser$parseNumber$normalized$1":I
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "StringBuilder(capacity).\u2026builderAction).toString()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    .local v0, "normalized":Ljava/lang/String;
    invoke-static {v0}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_3

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    .line 83
    .local v1, "it":I
    const/4 v2, 0x0

    .line 36
    .local v2, "$i$a$-let-VoiceSettingValueParser$parseNumber$1":I
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    return-object v3

    .line 38
    .end local v1    # "it":I
    .end local v2    # "$i$a$-let-VoiceSettingValueParser$parseNumber$1":I
    :cond_3
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    .local v1, "$this$any$iv":Ljava/lang/CharSequence;
    const/4 v2, 0x0

    .line 84
    .local v2, "$i$f$any":I
    const/4 v3, 0x0

    :goto_3
    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    const/16 v6, 0x4f70

    const/16 v7, 0x767e

    const/16 v9, 0x62fe

    const/16 v10, 0x5341

    if-ge v3, v4, :cond_7

    invoke-interface {v1, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    .local v4, "element$iv":C
    move v11, v4

    .local v11, "it":C
    const/4 v12, 0x0

    .line 38
    .local v12, "$i$a$-any-VoiceSettingValueParser$parseNumber$hasUnit$1":I
    if-eq v11, v10, :cond_5

    if-eq v11, v9, :cond_5

    if-eq v11, v7, :cond_5

    if-ne v11, v6, :cond_4

    goto :goto_4

    :cond_4
    const/4 v11, 0x0

    goto :goto_5

    :cond_5
    :goto_4
    move v11, v8

    .line 84
    .end local v11    # "it":C
    .end local v12    # "$i$a$-any-VoiceSettingValueParser$parseNumber$hasUnit$1":I
    :goto_5
    if-eqz v11, :cond_6

    move v1, v8

    goto :goto_6

    .end local v4    # "element$iv":C
    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 85
    :cond_7
    const/4 v1, 0x0

    .line 38
    .end local v1    # "$this$any$iv":Ljava/lang/CharSequence;
    .end local v2    # "$i$f$any":I
    :goto_6
    nop

    .line 39
    .local v1, "hasUnit":Z
    const/4 v2, 0x0

    if-nez v1, :cond_a

    .line 40
    const/4 v3, 0x0

    .line 41
    .local v3, "value":I
    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    .local v4, "$this$forEach$iv":Ljava/lang/CharSequence;
    const/4 v6, 0x0

    .line 86
    .local v6, "$i$f$forEach":I
    const/4 v5, 0x0

    :goto_7
    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-ge v5, v7, :cond_9

    invoke-interface {v4, v5}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    .restart local v7    # "element$iv":C
    move v8, v7

    .local v8, "char":C
    const/4 v9, 0x0

    .line 42
    .local v9, "$i$a$-forEach-VoiceSettingValueParser$parseNumber$2":I
    sget-object v10, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

    invoke-direct {v10, v8}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->chineseDigit(C)Ljava/lang/Integer;

    move-result-object v10

    if-eqz v10, :cond_8

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    .line 43
    .local v10, "digit":I
    mul-int/lit8 v11, v3, 0xa

    add-int v3, v11, v10

    .line 44
    nop

    .line 86
    .end local v8    # "char":C
    .end local v9    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$2":I
    .end local v10    # "digit":I
    nop

    .end local v7    # "element$iv":C
    add-int/lit8 v5, v5, 0x1

    goto :goto_7

    .line 42
    .restart local v7    # "element$iv":C
    .restart local v8    # "char":C
    .restart local v9    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$2":I
    :cond_8
    return-object v2

    .line 87
    .end local v7    # "element$iv":C
    .end local v8    # "char":C
    .end local v9    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$2":I
    :cond_9
    nop

    .line 45
    .end local v4    # "$this$forEach$iv":Ljava/lang/CharSequence;
    .end local v6    # "$i$f$forEach":I
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    return-object v2

    .line 48
    .end local v3    # "value":I
    :cond_a
    const/4 v3, 0x0

    .line 49
    .local v3, "total":I
    const/4 v4, 0x0

    .line 50
    .local v4, "digit":I
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    .local v11, "$this$forEach$iv":Ljava/lang/CharSequence;
    const/4 v12, 0x0

    .line 88
    .local v12, "$i$f$forEach":I
    const/4 v13, 0x0

    :goto_8
    invoke-interface {v11}, Ljava/lang/CharSequence;->length()I

    move-result v14

    if-ge v13, v14, :cond_14

    invoke-interface {v11, v13}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v14

    .local v14, "element$iv":C
    move v15, v14

    .local v15, "char":C
    const/16 v16, 0x0

    .line 51
    .local v16, "$i$a$-forEach-VoiceSettingValueParser$parseNumber$3":I
    nop

    .line 52
    if-ne v15, v10, :cond_b

    :goto_9
    move/from16 v17, v8

    goto :goto_a

    :cond_b
    if-ne v15, v9, :cond_c

    goto :goto_9

    :cond_c
    const/16 v17, 0x0

    :goto_a
    if-eqz v17, :cond_e

    .line 53
    if-nez v4, :cond_d

    move/from16 v17, v8

    goto :goto_b

    :cond_d
    move/from16 v17, v4

    :goto_b
    mul-int/lit8 v17, v17, 0xa

    add-int v3, v3, v17

    .line 54
    const/4 v4, 0x0

    goto :goto_f

    .line 56
    :cond_e
    if-ne v15, v7, :cond_f

    :goto_c
    move/from16 v17, v8

    goto :goto_d

    :cond_f
    if-ne v15, v6, :cond_10

    goto :goto_c

    :cond_10
    const/16 v17, 0x0

    :goto_d
    if-eqz v17, :cond_12

    .line 57
    if-nez v4, :cond_11

    move/from16 v17, v8

    goto :goto_e

    :cond_11
    move/from16 v17, v4

    :goto_e
    mul-int/lit8 v17, v17, 0x64

    add-int v3, v3, v17

    .line 58
    const/4 v4, 0x0

    goto :goto_f

    .line 60
    :cond_12
    sget-object v5, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;

    invoke-direct {v5, v15}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->chineseDigit(C)Ljava/lang/Integer;

    move-result-object v5

    if-eqz v5, :cond_13

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    move v4, v5

    .line 62
    :goto_f
    nop

    .line 88
    .end local v15    # "char":C
    .end local v16    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$3":I
    nop

    .end local v14    # "element$iv":C
    add-int/lit8 v13, v13, 0x1

    goto :goto_8

    .line 60
    .restart local v14    # "element$iv":C
    .restart local v15    # "char":C
    .restart local v16    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$3":I
    :cond_13
    return-object v2

    .line 89
    .end local v14    # "element$iv":C
    .end local v15    # "char":C
    .end local v16    # "$i$a$-forEach-VoiceSettingValueParser$parseNumber$3":I
    :cond_14
    nop

    .line 63
    .end local v11    # "$this$forEach$iv":Ljava/lang/CharSequence;
    .end local v12    # "$i$f$forEach":I
    add-int v2, v3, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method public final parse(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;
    .locals 7
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->numberPattern:Lkotlin/text/Regex;

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/Regex;->findAll$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/sequences/Sequence;

    move-result-object v0

    invoke-static {v0}, Lkotlin/sequences/SequencesKt;->lastOrNull(Lkotlin/sequences/Sequence;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lkotlin/text/MatchResult;

    if-eqz v0, :cond_5

    invoke-interface {v0}, Lkotlin/text/MatchResult;->getValue()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 19
    .local v0, "token":Ljava/lang/String;
    :cond_0
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueParser;->parseNumber(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 20
    .local v1, "value":I
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    const-string/jumbo v6, "\u767e\u5206\u4e4b"

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v5, v6, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 21
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    const-string/jumbo v6, "\u767e\u5206\u6bd4"

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v5, v6, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 22
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    const/16 v6, 0x25

    invoke-static {v5, v6, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;CZILjava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 23
    move-object v5, p1

    check-cast v5, Ljava/lang/CharSequence;

    const v6, 0xff05

    invoke-static {v5, v6, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;CZILjava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    const/4 v2, 0x1

    .line 20
    :cond_2
    nop

    .line 24
    .local v2, "isPercent":Z
    new-instance v3, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;

    .line 25
    nop

    .line 26
    if-eqz v2, :cond_3

    sget-object v4, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->PERCENT:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    goto :goto_0

    :cond_3
    sget-object v4, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->LEVEL:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    .line 24
    :goto_0
    invoke-direct {v3, v1, v4}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValue;-><init>(ILcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;)V

    return-object v3

    .line 19
    .end local v1    # "value":I
    .end local v2    # "isPercent":Z
    :cond_4
    return-object v4

    .line 18
    .end local v0    # "token":Ljava/lang/String;
    :cond_5
    :goto_1
    return-object v4
.end method
