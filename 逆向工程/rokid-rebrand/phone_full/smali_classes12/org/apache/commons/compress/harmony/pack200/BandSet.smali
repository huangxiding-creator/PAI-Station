.class public abstract Lorg/apache/commons/compress/harmony/pack200/BandSet;
.super Ljava/lang/Object;
.source "BandSet.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;,
        Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;
    }
.end annotation


# static fields
.field private static final effortThresholds:[I


# instance fields
.field private canonicalLargest:[J

.field private canonicalSmallest:[J

.field final effort:I

.field protected final segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 38
    const/16 v0, 0xa

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effortThresholds:[I

    return-void

    :array_0
    .array-data 4
        0x0
        0x0
        0x3e8
        0x1f4
        0x64
        0x64
        0x64
        0x64
        0x64
        0x0
    .end array-data
.end method

.method public constructor <init>(ILorg/apache/commons/compress/harmony/pack200/SegmentHeader;)V
    .locals 0
    .param p1, "effort"    # I
    .param p2, "header"    # Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    .line 51
    iput-object p2, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    .line 52
    return-void
.end method

.method private analyseBand(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .locals 17
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "band"    # [I
    .param p3, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 173
    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move-object/from16 v15, p2

    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    invoke-direct {v0, v13}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;-><init>(Lorg/apache/commons/compress/harmony/pack200/BandSet;)V

    move-object v12, v0

    .line 175
    .local v12, "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    iget-object v0, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalLargest:[J

    if-nez v0, :cond_0

    .line 176
    const/16 v0, 0x74

    new-array v1, v0, [J

    iput-object v1, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalLargest:[J

    .line 177
    new-array v0, v0, [J

    iput-object v0, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalSmallest:[J

    .line 178
    const/4 v0, 0x1

    .local v0, "i":I
    :goto_0
    iget-object v1, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalLargest:[J

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 179
    iget-object v1, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalLargest:[J

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCanonicalCodec(I)Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    move-result-object v2

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v2

    aput-wide v2, v1, v0

    .line 180
    iget-object v1, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->canonicalSmallest:[J

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCanonicalCodec(I)Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    move-result-object v2

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v2

    aput-wide v2, v1, v0

    .line 178
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 183
    .end local v0    # "i":I
    :cond_0
    new-instance v4, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;

    invoke-direct {v4, v13, v15}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;-><init>(Lorg/apache/commons/compress/harmony/pack200/BandSet;[I)V

    .line 186
    .local v4, "bandData":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;
    move-object/from16 v11, p3

    invoke-virtual {v11, v15}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v10

    .line 187
    .local v10, "encoded":[B
    invoke-static {v12, v10}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$102(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B)[B

    .line 190
    array-length v0, v10

    array-length v1, v15

    add-int/lit8 v1, v1, 0x17

    iget v2, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    mul-int/lit8 v2, v2, 0x2

    sub-int/2addr v1, v2

    if-gt v0, v1, :cond_1

    .line 191
    return-object v12

    .line 195
    :cond_1
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->anyNegatives()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$300(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v0

    int-to-long v0, v0

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-gtz v0, :cond_2

    .line 196
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v15}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v0

    invoke-static {v12, v0}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$102(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B)[B

    .line 197
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-static {v12, v0}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$002(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 198
    return-object v12

    .line 202
    :cond_2
    iget v0, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    const/4 v1, 0x3

    if-le v0, v1, :cond_4

    const-string v0, "POPULATION"

    invoke-virtual {v14, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 203
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->numDistinctValues()I

    move-result v6

    .line 204
    .local v6, "numDistinctValues":I
    int-to-float v0, v6

    array-length v1, v15

    int-to-float v1, v1

    div-float v7, v0, v1

    .line 207
    .local v7, "distinctValuesAsProportion":F
    const/16 v0, 0x64

    if-lt v6, v0, :cond_3

    float-to-double v0, v7

    const-wide v2, 0x3f947ae147ae147bL    # 0.02

    cmpg-double v0, v0, v2

    if-ltz v0, :cond_3

    iget v0, v13, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    const/4 v1, 0x6

    if-le v0, v1, :cond_4

    float-to-double v0, v7

    const-wide v2, 0x3fa47ae147ae147bL    # 0.04

    cmpg-double v0, v0, v2

    if-gez v0, :cond_4

    .line 209
    :cond_3
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v5, v12

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->encodeWithPopulationCodec(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)V

    .line 210
    invoke-direct {v13, v12}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->timeToStop(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 211
    return-object v12

    .line 216
    .end local v6    # "numDistinctValues":I
    .end local v7    # "distinctValuesAsProportion":F
    :cond_4
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 219
    .local v0, "codecFamiliesToTry":Ljava/util/List;
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->mainlyPositiveDeltas()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->mainlySmallDeltas()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 220
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 223
    :cond_5
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->wellCorrelated()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 224
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->mainlyPositiveDeltas()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 225
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 226
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 227
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 228
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 229
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 230
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 231
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 232
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 233
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_1

    .line 235
    :cond_6
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 236
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 237
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 238
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 239
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 240
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaSignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 241
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaSignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 243
    :cond_7
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->anyNegatives()Z

    move-result v1

    if-eqz v1, :cond_8

    .line 244
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaSignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 245
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaSignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 246
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 247
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 248
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 249
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 250
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaSignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 252
    :cond_8
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 253
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 254
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 255
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 256
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->nonDeltaUnsignedCodecs2:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 257
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs1:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 258
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs3:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 259
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs4:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 260
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/CanonicalCodecFamilies;->deltaUnsignedCodecs5:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 262
    :goto_1
    const-string v1, "cpint"

    invoke-virtual {v14, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 263
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->print(Ljava/lang/String;)V

    .line 266
    :cond_9
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "iterator":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_b

    .line 267
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    check-cast v2, [Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 268
    .local v2, "family":[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    move-object/from16 v5, p0

    move-object/from16 v6, p1

    move-object/from16 v7, p2

    move-object/from16 v8, p3

    move-object v9, v4

    move-object v3, v10

    .end local v10    # "encoded":[B
    .local v3, "encoded":[B
    move-object v10, v12

    move-object v11, v3

    move-object/from16 v16, v0

    move-object v0, v12

    .end local v12    # "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .local v0, "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .local v16, "codecFamiliesToTry":Ljava/util/List;
    move-object v12, v2

    invoke-direct/range {v5 .. v12}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->tryCodecs(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)V

    .line 269
    invoke-direct {v13, v0}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->timeToStop(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Z

    move-result v5

    if-eqz v5, :cond_a

    .line 270
    goto :goto_3

    .line 272
    .end local v2    # "family":[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    :cond_a
    move-object/from16 v11, p3

    move-object v12, v0

    move-object v10, v3

    move-object/from16 v0, v16

    goto :goto_2

    .line 266
    .end local v3    # "encoded":[B
    .end local v16    # "codecFamiliesToTry":Ljava/util/List;
    .local v0, "codecFamiliesToTry":Ljava/util/List;
    .restart local v10    # "encoded":[B
    .restart local v12    # "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    :cond_b
    move-object/from16 v16, v0

    move-object v3, v10

    move-object v0, v12

    .line 274
    .end local v1    # "iterator":Ljava/util/Iterator;
    .end local v10    # "encoded":[B
    .end local v12    # "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .local v0, "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .restart local v3    # "encoded":[B
    .restart local v16    # "codecFamiliesToTry":Ljava/util/List;
    :goto_3
    return-object v0
.end method

.method private encodeWithPopulationCodec(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)V
    .locals 31
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "band"    # [I
    .param p3, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "bandData"    # Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;
    .param p5, "results"    # Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 356
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move-object/from16 v3, p5

    invoke-static/range {p5 .. p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$400(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v4

    const/4 v5, 0x3

    add-int/2addr v4, v5

    invoke-static {v3, v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$402(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;I)I

    .line 357
    invoke-static/range {p4 .. p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$900(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)Ljava/util/Map;

    move-result-object v4

    .line 359
    .local v4, "distinctValues":Ljava/util/Map;
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    .line 360
    .local v6, "favoured":Ljava/util/List;
    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .local v7, "iterator":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    const/16 v9, 0x100

    const/4 v10, 0x2

    if-eqz v8, :cond_2

    .line 361
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Integer;

    .line 362
    .local v8, "value":Ljava/lang/Integer;
    invoke-interface {v4, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Integer;

    .line 363
    .local v11, "count":Ljava/lang/Integer;
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v12

    if-gt v12, v10, :cond_0

    invoke-interface {v4}, Ljava/util/Map;->size()I

    move-result v10

    if-ge v10, v9, :cond_1

    .line 364
    :cond_0
    invoke-interface {v6, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 366
    .end local v8    # "value":Ljava/lang/Integer;
    .end local v11    # "count":Ljava/lang/Integer;
    :cond_1
    goto :goto_0

    .line 369
    .end local v7    # "iterator":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v4}, Ljava/util/Map;->size()I

    move-result v7

    const/16 v8, 0xff

    if-le v7, v8, :cond_3

    .line 370
    new-instance v7, Lorg/apache/commons/compress/harmony/pack200/BandSet$$ExternalSyntheticLambda0;

    invoke-direct {v7, v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$$ExternalSyntheticLambda0;-><init>(Ljava/util/Map;)V

    invoke-static {v6, v7}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 374
    :cond_3
    new-instance v7, Lorg/apache/commons/compress/harmony/pack200/IntList;

    invoke-direct {v7}, Lorg/apache/commons/compress/harmony/pack200/IntList;-><init>()V

    .line 375
    .local v7, "unfavoured":Lorg/apache/commons/compress/harmony/pack200/IntList;
    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    .line 376
    .local v8, "favouredToIndex":Ljava/util/Map;
    const/4 v11, 0x0

    .local v11, "i":I
    :goto_1
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v12

    if-ge v11, v12, :cond_4

    .line 377
    invoke-interface {v6, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Integer;

    .line 378
    .local v12, "value":Ljava/lang/Integer;
    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v8, v12, v13}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 376
    .end local v12    # "value":Ljava/lang/Integer;
    add-int/lit8 v11, v11, 0x1

    goto :goto_1

    .line 381
    .end local v11    # "i":I
    :cond_4
    array-length v11, v1

    new-array v11, v11, [I

    .line 382
    .local v11, "tokens":[I
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_2
    array-length v13, v1

    const/4 v14, 0x0

    const/4 v15, 0x1

    if-ge v12, v13, :cond_6

    .line 383
    aget v13, v1, v12

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v8, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    .line 384
    .local v13, "favouredIndex":Ljava/lang/Integer;
    if-nez v13, :cond_5

    .line 385
    aput v14, v11, v12

    .line 386
    aget v14, v1, v12

    invoke-virtual {v7, v14}, Lorg/apache/commons/compress/harmony/pack200/IntList;->add(I)Z

    goto :goto_3

    .line 388
    :cond_5
    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v14

    add-int/2addr v14, v15

    aput v14, v11, v12

    .line 382
    .end local v13    # "favouredIndex":Ljava/lang/Integer;
    :goto_3
    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    .line 391
    .end local v12    # "i":I
    :cond_6
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v12

    sub-int/2addr v12, v15

    invoke-interface {v6, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    invoke-interface {v6, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 392
    invoke-virtual {v0, v6}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->integerListToArray(Ljava/util/List;)[I

    move-result-object v12

    .line 393
    .local v12, "favouredBand":[I
    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/pack200/IntList;->toArray()[I

    move-result-object v13

    .line 396
    .local v13, "unfavouredBand":[I
    const-string v10, "POPULATION"

    invoke-direct {v0, v10, v12, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->analyseBand(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    move-result-object v17

    .line 397
    .local v17, "favouredResults":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    invoke-direct {v0, v10, v13, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->analyseBand(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    move-result-object v18

    .line 399
    .local v18, "unfavouredResults":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    const/16 v19, 0x0

    .line 400
    .local v19, "tdefL":I
    const/16 v20, 0x0

    .line 401
    .local v20, "l":I
    const/16 v21, 0x0

    .line 403
    .local v21, "tokenCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v22

    add-int/lit8 v14, v22, -0x1

    .line 404
    .local v14, "k":I
    if-ge v14, v9, :cond_7

    .line 405
    const/16 v19, 0x1

    .line 406
    sget-object v9, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v9, v11}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v9

    move/from16 v0, v20

    move-object/from16 v10, v21

    .local v9, "tokensEncoded":[B
    goto/16 :goto_5

    .line 408
    .end local v9    # "tokensEncoded":[B
    :cond_7
    invoke-direct {v0, v10, v11, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->analyseBand(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    move-result-object v9

    .line 409
    .local v9, "tokenResults":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    invoke-static {v9}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$000(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v10

    .line 410
    .end local v21    # "tokenCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .local v10, "tokenCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-static {v9}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v21

    .line 411
    .local v21, "tokensEncoded":[B
    if-nez v10, :cond_8

    .line 412
    move-object/from16 v10, p3

    .line 414
    :cond_8
    move-object/from16 v22, v10

    check-cast v22, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual/range {v22 .. v22}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v20

    .line 415
    move-object/from16 v22, v10

    check-cast v22, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual/range {v22 .. v22}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getH()I

    move-result v5

    .line 416
    .local v5, "h":I
    move-object/from16 v22, v10

    check-cast v22, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual/range {v22 .. v22}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getS()I

    move-result v22

    .line 417
    .local v22, "s":I
    move-object/from16 v25, v10

    check-cast v25, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getB()I

    move-result v15

    .line 418
    .local v15, "b":I
    move-object/from16 v25, v10

    check-cast v25, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual/range {v25 .. v25}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v25

    .line 419
    .local v25, "d":I
    if-nez v22, :cond_a

    if-nez v25, :cond_a

    .line 420
    const/16 v27, 0x1

    .line 421
    .local v27, "canUseTDefL":Z
    const/4 v0, 0x1

    if-le v15, v0, :cond_9

    .line 422
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    add-int/lit8 v1, v15, -0x1

    invoke-direct {v0, v1, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    .line 423
    .local v0, "oneLowerB":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v28

    move-object/from16 v30, v0

    .end local v0    # "oneLowerB":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .local v30, "oneLowerB":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    int-to-long v0, v14

    cmp-long v0, v28, v0

    if-ltz v0, :cond_9

    .line 424
    const/16 v27, 0x0

    .line 427
    .end local v30    # "oneLowerB":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    :cond_9
    if-eqz v27, :cond_a

    .line 428
    sparse-switch v20, :sswitch_data_0

    goto :goto_4

    .line 460
    :sswitch_0
    const/16 v19, 0xb

    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 457
    :sswitch_1
    const/16 v19, 0xa

    .line 458
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 454
    :sswitch_2
    const/16 v19, 0x9

    .line 455
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 451
    :sswitch_3
    const/16 v19, 0x8

    .line 452
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 448
    :sswitch_4
    const/16 v19, 0x7

    .line 449
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 445
    :sswitch_5
    const/16 v19, 0x6

    .line 446
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 442
    :sswitch_6
    const/16 v19, 0x5

    .line 443
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 439
    :sswitch_7
    const/16 v19, 0x4

    .line 440
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 436
    :sswitch_8
    const/16 v19, 0x3

    .line 437
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 433
    :sswitch_9
    const/16 v19, 0x2

    .line 434
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 430
    :sswitch_a
    const/16 v19, 0x1

    .line 431
    move/from16 v0, v20

    move-object/from16 v9, v21

    goto :goto_5

    .line 467
    .end local v5    # "h":I
    .end local v9    # "tokenResults":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .end local v15    # "b":I
    .end local v22    # "s":I
    .end local v25    # "d":I
    .end local v27    # "canUseTDefL":Z
    :cond_a
    :goto_4
    move/from16 v0, v20

    move-object/from16 v9, v21

    .end local v20    # "l":I
    .end local v21    # "tokensEncoded":[B
    .local v0, "l":I
    .local v9, "tokensEncoded":[B
    :goto_5
    invoke-static/range {v17 .. v17}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v1

    .line 468
    .local v1, "favouredEncoded":[B
    invoke-static/range {v18 .. v18}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v5

    .line 469
    .local v5, "unfavouredEncoded":[B
    invoke-static/range {v17 .. v17}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$000(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v15

    .line 470
    .local v15, "favouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    move-object/from16 v20, v4

    .end local v4    # "distinctValues":Ljava/util/Map;
    .local v20, "distinctValues":Ljava/util/Map;
    invoke-static/range {v18 .. v18}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$000(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    .line 472
    .local v4, "unfavouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    move-object/from16 v21, v6

    if-nez v15, :cond_b

    const/4 v6, 0x1

    goto :goto_6

    :cond_b
    const/4 v6, 0x0

    .end local v6    # "favoured":Ljava/util/List;
    .local v21, "favoured":Ljava/util/List;
    :goto_6
    add-int/lit16 v6, v6, 0x8d

    mul-int/lit8 v22, v19, 0x4

    add-int v6, v6, v22

    if-nez v4, :cond_c

    const/16 v16, 0x2

    goto :goto_7

    :cond_c
    const/16 v16, 0x0

    :goto_7
    add-int v6, v6, v16

    .line 473
    .local v6, "specifier":I
    move-object/from16 v16, v7

    .end local v7    # "unfavoured":Lorg/apache/commons/compress/harmony/pack200/IntList;
    .local v16, "unfavoured":Lorg/apache/commons/compress/harmony/pack200/IntList;
    new-instance v7, Lorg/apache/commons/compress/harmony/pack200/IntList;

    move-object/from16 v22, v8

    const/4 v8, 0x3

    .end local v8    # "favouredToIndex":Ljava/util/Map;
    .local v22, "favouredToIndex":Ljava/util/Map;
    invoke-direct {v7, v8}, Lorg/apache/commons/compress/harmony/pack200/IntList;-><init>(I)V

    .line 474
    .local v7, "extraBandMetadata":Lorg/apache/commons/compress/harmony/pack200/IntList;
    const/4 v8, 0x0

    if-eqz v15, :cond_d

    .line 475
    move-object/from16 v24, v11

    .end local v11    # "tokens":[I
    .local v24, "tokens":[I
    invoke-static {v15, v8}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v11

    .line 476
    .local v11, "specifiers":[I
    const/16 v25, 0x0

    move/from16 v8, v25

    .local v8, "i":I
    :goto_8
    move-object/from16 v25, v12

    .end local v12    # "favouredBand":[I
    .local v25, "favouredBand":[I
    array-length v12, v11

    if-ge v8, v12, :cond_e

    .line 477
    aget v12, v11, v8

    invoke-virtual {v7, v12}, Lorg/apache/commons/compress/harmony/pack200/IntList;->add(I)Z

    .line 476
    add-int/lit8 v8, v8, 0x1

    move-object/from16 v12, v25

    goto :goto_8

    .line 474
    .end local v8    # "i":I
    .end local v24    # "tokens":[I
    .end local v25    # "favouredBand":[I
    .local v11, "tokens":[I
    .restart local v12    # "favouredBand":[I
    :cond_d
    move-object/from16 v24, v11

    move-object/from16 v25, v12

    .line 480
    .end local v11    # "tokens":[I
    .end local v12    # "favouredBand":[I
    .restart local v24    # "tokens":[I
    .restart local v25    # "favouredBand":[I
    :cond_e
    if-nez v19, :cond_f

    .line 481
    const/4 v8, 0x0

    invoke-static {v10, v8}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v11

    .line 482
    .local v11, "specifiers":[I
    const/4 v8, 0x0

    .restart local v8    # "i":I
    :goto_9
    array-length v12, v11

    if-ge v8, v12, :cond_f

    .line 483
    aget v12, v11, v8

    invoke-virtual {v7, v12}, Lorg/apache/commons/compress/harmony/pack200/IntList;->add(I)Z

    .line 482
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    .line 486
    .end local v8    # "i":I
    .end local v11    # "specifiers":[I
    :cond_f
    if-eqz v4, :cond_10

    .line 487
    const/4 v8, 0x0

    invoke-static {v4, v8}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v8

    .line 488
    .local v8, "specifiers":[I
    const/4 v11, 0x0

    .local v11, "i":I
    :goto_a
    array-length v12, v8

    if-ge v11, v12, :cond_10

    .line 489
    aget v12, v8, v11

    invoke-virtual {v7, v12}, Lorg/apache/commons/compress/harmony/pack200/IntList;->add(I)Z

    .line 488
    add-int/lit8 v11, v11, 0x1

    goto :goto_a

    .line 492
    .end local v8    # "specifiers":[I
    .end local v11    # "i":I
    :cond_10
    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/pack200/IntList;->toArray()[I

    move-result-object v8

    .line 493
    .local v8, "extraMetadata":[I
    sget-object v11, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v11, v8}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v11

    .line 494
    .local v11, "extraMetadataEncoded":[B
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v12

    if-eqz v12, :cond_11

    .line 495
    rsub-int/lit8 v6, v6, -0x1

    goto :goto_b

    .line 497
    :cond_11
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v12

    add-int/2addr v6, v12

    .line 499
    :goto_b
    filled-new-array {v6}, [I

    move-result-object v12

    invoke-virtual {v2, v12}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v12

    .line 500
    .local v12, "firstValueEncoded":[B
    array-length v2, v12

    move/from16 v26, v6

    .end local v6    # "specifier":I
    .local v26, "specifier":I
    array-length v6, v1

    add-int/2addr v2, v6

    array-length v6, v9

    add-int/2addr v2, v6

    array-length v6, v5

    add-int/2addr v2, v6

    .line 503
    .local v2, "totalBandLength":I
    array-length v6, v11

    add-int/2addr v6, v2

    move-object/from16 v27, v7

    .end local v7    # "extraBandMetadata":Lorg/apache/commons/compress/harmony/pack200/IntList;
    .local v27, "extraBandMetadata":Lorg/apache/commons/compress/harmony/pack200/IntList;
    invoke-static/range {p5 .. p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v7

    array-length v7, v7

    if-ge v6, v7, :cond_13

    .line 504
    invoke-static/range {p5 .. p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$800(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v6

    invoke-static/range {p5 .. p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v7

    array-length v7, v7

    move-object/from16 v28, v13

    .end local v13    # "unfavouredBand":[I
    .local v28, "unfavouredBand":[I
    array-length v13, v11

    add-int/2addr v13, v2

    sub-int/2addr v7, v13

    add-int/2addr v6, v7

    invoke-static {v3, v6}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$802(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;I)I

    .line 505
    new-array v6, v2, [B

    .line 506
    .local v6, "encodedBand":[B
    array-length v7, v12

    const/4 v13, 0x0

    invoke-static {v12, v13, v6, v13, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 507
    array-length v7, v12

    move/from16 v23, v2

    .end local v2    # "totalBandLength":I
    .local v23, "totalBandLength":I
    array-length v2, v1

    invoke-static {v1, v13, v6, v7, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 508
    array-length v2, v12

    array-length v7, v1

    add-int/2addr v2, v7

    array-length v7, v9

    invoke-static {v9, v13, v6, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 510
    array-length v2, v12

    array-length v7, v1

    add-int/2addr v2, v7

    array-length v7, v9

    add-int/2addr v2, v7

    array-length v7, v5

    invoke-static {v5, v13, v6, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 512
    invoke-static {v3, v6}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$102(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B)[B

    .line 513
    invoke-static {v3, v8}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$202(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[I)[I

    .line 514
    if-eqz v0, :cond_12

    .line 515
    new-instance v2, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    invoke-direct {v2, v15, v0, v4}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;-><init>(Lorg/apache/commons/compress/harmony/pack200/Codec;ILorg/apache/commons/compress/harmony/pack200/Codec;)V

    invoke-static {v3, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$002(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    goto :goto_c

    .line 517
    :cond_12
    new-instance v2, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    invoke-direct {v2, v15, v10, v4}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;-><init>(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)V

    invoke-static {v3, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$002(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    goto :goto_c

    .line 503
    .end local v6    # "encodedBand":[B
    .end local v23    # "totalBandLength":I
    .end local v28    # "unfavouredBand":[I
    .restart local v2    # "totalBandLength":I
    .restart local v13    # "unfavouredBand":[I
    :cond_13
    move/from16 v23, v2

    move-object/from16 v28, v13

    .line 520
    .end local v2    # "totalBandLength":I
    .end local v13    # "unfavouredBand":[I
    .restart local v23    # "totalBandLength":I
    .restart local v28    # "unfavouredBand":[I
    :goto_c
    return-void

    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_a
        0x8 -> :sswitch_9
        0x10 -> :sswitch_8
        0x20 -> :sswitch_7
        0x40 -> :sswitch_6
        0x80 -> :sswitch_5
        0xc0 -> :sswitch_4
        0xe0 -> :sswitch_3
        0xf0 -> :sswitch_2
        0xf8 -> :sswitch_1
        0xfc -> :sswitch_0
    .end sparse-switch
.end method

.method private flatten([[J)[J
    .locals 8
    .param p1, "flags"    # [[J

    .line 629
    const/4 v0, 0x0

    .line 630
    .local v0, "totalSize":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_0

    .line 631
    aget-object v2, p1, v1

    array-length v2, v2

    add-int/2addr v0, v2

    .line 630
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 633
    .end local v1    # "i":I
    :cond_0
    new-array v1, v0, [J

    .line 634
    .local v1, "flatArray":[J
    const/4 v2, 0x0

    .line 635
    .local v2, "index":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    array-length v4, p1

    if-ge v3, v4, :cond_2

    .line 636
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_2
    aget-object v5, p1, v3

    array-length v5, v5

    if-ge v4, v5, :cond_1

    .line 637
    aget-object v5, p1, v3

    aget-wide v6, v5, v4

    aput-wide v6, v1, v2

    .line 638
    add-int/lit8 v2, v2, 0x1

    .line 636
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 635
    .end local v4    # "j":I
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 641
    .end local v3    # "i":I
    :cond_2
    return-object v1
.end method

.method static synthetic lambda$encodeWithPopulationCodec$0(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 2
    .param p0, "distinctValues"    # Ljava/util/Map;
    .param p1, "arg0"    # Ljava/lang/Object;
    .param p2, "arg1"    # Ljava/lang/Object;

    .line 371
    invoke-interface {p0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/Integer;->compareTo(Ljava/lang/Integer;)I

    move-result v0

    return v0
.end method

.method private timeToStop(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Z
    .locals 4
    .param p1, "results"    # Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    .line 280
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    const/4 v1, 0x6

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-le v0, v1, :cond_1

    .line 281
    invoke-static {p1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$400(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v0

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    mul-int/lit8 v1, v1, 0x2

    if-lt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    return v2

    .line 283
    :cond_1
    invoke-static {p1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$400(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v0

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    if-lt v0, v1, :cond_2

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    return v2
.end method

.method private tryCodecs(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)V
    .locals 8
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "band"    # [I
    .param p3, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "bandData"    # Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;
    .param p5, "results"    # Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .param p6, "encoded"    # [B
    .param p7, "potentialCodecs"    # [Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 291
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p7

    if-ge v0, v1, :cond_5

    .line 292
    aget-object v1, p7, v0

    .line 293
    .local v1, "potential":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v1, p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 294
    return-void

    .line 297
    :cond_0
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_2

    .line 298
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$500(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-ltz v2, :cond_3

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$600(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-gtz v2, :cond_3

    .line 299
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$300(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-ltz v2, :cond_3

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$700(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-gtz v2, :cond_3

    .line 301
    invoke-virtual {v1, p2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v2

    .line 302
    .local v2, "encoded2":[B
    invoke-static {p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$408(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    .line 303
    invoke-static {v1, v3}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v3

    invoke-virtual {p3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v3

    .line 304
    .local v3, "specifierEncoded":[B
    array-length v4, p6

    array-length v5, v2

    sub-int/2addr v4, v5

    array-length v5, v3

    sub-int/2addr v4, v5

    .line 305
    .local v4, "saved":I
    invoke-static {p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$800(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v5

    if-le v4, v5, :cond_1

    .line 306
    invoke-static {p5, v1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$002(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 307
    invoke-static {p5, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$102(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B)[B

    .line 308
    invoke-static {p5, v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$802(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;I)I

    .line 310
    .end local v2    # "encoded2":[B
    .end local v3    # "specifierEncoded":[B
    .end local v4    # "saved":I
    :cond_1
    goto :goto_1

    .line 311
    :cond_2
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$300(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-ltz v2, :cond_3

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v4

    invoke-static {p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;->access$700(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandData;)I

    move-result v2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-gtz v2, :cond_3

    .line 312
    invoke-virtual {v1, p2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v2

    .line 313
    .restart local v2    # "encoded2":[B
    invoke-static {p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$408(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    .line 314
    invoke-static {v1, v3}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v3

    invoke-virtual {p3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v3

    .line 315
    .restart local v3    # "specifierEncoded":[B
    array-length v4, p6

    array-length v5, v2

    sub-int/2addr v4, v5

    array-length v5, v3

    sub-int/2addr v4, v5

    .line 316
    .restart local v4    # "saved":I
    invoke-static {p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$800(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)I

    move-result v5

    if-le v4, v5, :cond_3

    .line 317
    invoke-static {p5, v1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$002(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 318
    invoke-static {p5, v2}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$102(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;[B)[B

    .line 319
    invoke-static {p5, v4}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$802(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;I)I

    .line 322
    .end local v2    # "encoded2":[B
    .end local v3    # "specifierEncoded":[B
    .end local v4    # "saved":I
    :cond_3
    :goto_1
    invoke-direct {p0, p5}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->timeToStop(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 323
    return-void

    .line 291
    .end local v1    # "potential":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    .line 326
    .end local v0    # "i":I
    :cond_5
    return-void
.end method


# virtual methods
.method protected cpEntryListToArray(Ljava/util/List;)[I
    .locals 4
    .param p1, "list"    # Ljava/util/List;

    .line 592
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [I

    .line 593
    .local v0, "array":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    .line 594
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->getIndex()I

    move-result v2

    aput v2, v0, v1

    .line 595
    aget v2, v0, v1

    if-ltz v2, :cond_0

    .line 593
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 596
    :cond_0
    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Index should be > 0"

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 599
    .end local v1    # "i":I
    :cond_1
    return-object v0
.end method

.method protected cpEntryOrNullListToArray(Ljava/util/List;)[I
    .locals 5
    .param p1, "theList"    # Ljava/util/List;

    .line 609
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [I

    .line 610
    .local v0, "array":[I
    const/4 v1, 0x0

    .local v1, "j":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_3

    .line 611
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;

    .line 612
    .local v2, "cpEntry":Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
    if-nez v2, :cond_0

    const/4 v3, 0x0

    goto :goto_1

    :cond_0
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->getIndex()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    :goto_1
    aput v3, v0, v1

    .line 613
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;->getIndex()I

    move-result v3

    if-ltz v3, :cond_1

    goto :goto_2

    .line 614
    :cond_1
    new-instance v3, Ljava/lang/RuntimeException;

    const-string v4, "Index should be > 0"

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 610
    .end local v2    # "cpEntry":Lorg/apache/commons/compress/harmony/pack200/ConstantPoolEntry;
    :cond_2
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 617
    .end local v1    # "j":I
    :cond_3
    return-object v0
.end method

.method public encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B
    .locals 10
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "ints"    # [I
    .param p3, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 99
    const/4 v0, 0x0

    .line 104
    .local v0, "encodedBand":[B
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-le v1, v4, :cond_5

    array-length v1, p2

    sget-object v5, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effortThresholds:[I

    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->effort:I

    aget v5, v5, v6

    if-lt v1, v5, :cond_5

    .line 105
    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->analyseBand(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;

    move-result-object v1

    .line 106
    .local v1, "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$000(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v5

    .line 107
    .local v5, "betterCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$100(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[B

    move-result-object v0

    .line 108
    if-eqz v5, :cond_5

    .line 109
    instance-of v6, v5, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v6, :cond_2

    .line 110
    invoke-static {v5, p3}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v6

    .line 111
    .local v6, "specifierBand":[I
    aget v7, v6, v3

    .line 112
    .local v7, "specifier":I
    array-length v8, v6

    if-le v8, v4, :cond_0

    .line 113
    const/4 v4, 0x1

    .local v4, "i":I
    :goto_0
    array-length v8, v6

    if-ge v4, v8, :cond_0

    .line 114
    iget-object v8, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    aget v9, v6, v4

    invoke-virtual {v8, v9}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->appendBandCodingSpecifier(I)V

    .line 113
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 117
    .end local v4    # "i":I
    :cond_0
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 118
    sub-int/2addr v2, v7

    .end local v7    # "specifier":I
    .local v2, "specifier":I
    goto :goto_1

    .line 120
    .end local v2    # "specifier":I
    .restart local v7    # "specifier":I
    :cond_1
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v2

    add-int/2addr v2, v7

    .line 122
    .end local v7    # "specifier":I
    .restart local v2    # "specifier":I
    :goto_1
    filled-new-array {v2}, [I

    move-result-object v4

    invoke-virtual {p3, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v4

    .line 123
    .local v4, "specifierEncoded":[B
    array-length v7, v4

    array-length v8, v0

    add-int/2addr v7, v8

    new-array v7, v7, [B

    .line 124
    .local v7, "band":[B
    array-length v8, v4

    invoke-static {v4, v3, v7, v3, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 125
    array-length v8, v4

    array-length v9, v0

    invoke-static {v0, v3, v7, v8, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 126
    return-object v7

    .line 128
    .end local v2    # "specifier":I
    .end local v4    # "specifierEncoded":[B
    .end local v6    # "specifierBand":[I
    .end local v7    # "band":[B
    :cond_2
    instance-of v6, v5, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    if-eqz v6, :cond_4

    .line 129
    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;->access$200(Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;)[I

    move-result-object v2

    .line 130
    .local v2, "extraSpecifierInfo":[I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_2
    array-length v4, v2

    if-ge v3, v4, :cond_3

    .line 131
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/BandSet;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    aget v6, v2, v3

    invoke-virtual {v4, v6}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->appendBandCodingSpecifier(I)V

    .line 130
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 133
    .end local v3    # "i":I
    :cond_3
    return-object v0

    .line 135
    .end local v2    # "extraSpecifierInfo":[I
    :cond_4
    instance-of v6, v5, Lorg/apache/commons/compress/harmony/pack200/RunCodec;

    .line 142
    .end local v1    # "results":Lorg/apache/commons/compress/harmony/pack200/BandSet$BandAnalysisResults;
    .end local v5    # "betterCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_5
    array-length v1, p2

    if-lez v1, :cond_9

    .line 143
    if-nez v0, :cond_6

    .line 144
    invoke-virtual {p3, p2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v0

    .line 146
    :cond_6
    aget v1, p2, v3

    .line 147
    .local v1, "first":I
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getB()I

    move-result v5

    if-eq v5, v4, :cond_8

    .line 148
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v4

    if-eqz v4, :cond_7

    const/16 v4, -0x100

    if-lt v1, v4, :cond_7

    if-gt v1, v2, :cond_7

    .line 149
    invoke-static {p3}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifierForDefaultCodec(Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)I

    move-result v4

    sub-int/2addr v2, v4

    .line 150
    .local v2, "specifier":I
    filled-new-array {v2}, [I

    move-result-object v4

    invoke-virtual {p3, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v4

    .line 151
    .restart local v4    # "specifierEncoded":[B
    array-length v5, v4

    array-length v6, v0

    add-int/2addr v5, v6

    new-array v5, v5, [B

    .line 152
    .local v5, "band":[B
    array-length v6, v4

    invoke-static {v4, v3, v5, v3, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 153
    array-length v6, v4

    array-length v7, v0

    invoke-static {v0, v3, v5, v6, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 154
    return-object v5

    .line 156
    .end local v2    # "specifier":I
    .end local v4    # "specifierEncoded":[B
    .end local v5    # "band":[B
    :cond_7
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v2

    if-nez v2, :cond_8

    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v2

    if-lt v1, v2, :cond_8

    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v2

    add-int/lit16 v2, v2, 0xff

    if-gt v1, v2, :cond_8

    .line 157
    invoke-static {p3}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifierForDefaultCodec(Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)I

    move-result v2

    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v4

    add-int/2addr v2, v4

    .line 158
    .restart local v2    # "specifier":I
    filled-new-array {v2}, [I

    move-result-object v4

    invoke-virtual {p3, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v4

    .line 159
    .restart local v4    # "specifierEncoded":[B
    array-length v5, v4

    array-length v6, v0

    add-int/2addr v5, v6

    new-array v5, v5, [B

    .line 160
    .restart local v5    # "band":[B
    array-length v6, v4

    invoke-static {v4, v3, v5, v3, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 161
    array-length v6, v4

    array-length v7, v0

    invoke-static {v0, v3, v5, v6, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 162
    return-object v5

    .line 165
    .end local v2    # "specifier":I
    .end local v4    # "specifierEncoded":[B
    .end local v5    # "band":[B
    :cond_8
    return-object v0

    .line 167
    .end local v1    # "first":I
    :cond_9
    new-array v1, v3, [B

    return-object v1
.end method

.method protected encodeFlags(Ljava/lang/String;[JLorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[B
    .locals 8
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "flags"    # [J
    .param p3, "loCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "hiCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "haveHiFlags"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 535
    if-nez p5, :cond_1

    .line 536
    array-length v0, p2

    new-array v0, v0, [I

    .line 537
    .local v0, "loBits":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p2

    if-ge v1, v2, :cond_0

    .line 538
    aget-wide v2, p2, v1

    long-to-int v2, v2

    aput v2, v0, v1

    .line 537
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 540
    .end local v1    # "i":I
    :cond_0
    invoke-virtual {p0, p1, v0, p3}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v1

    return-object v1

    .line 542
    .end local v0    # "loBits":[I
    :cond_1
    array-length v0, p2

    new-array v0, v0, [I

    .line 543
    .local v0, "hiBits":[I
    array-length v1, p2

    new-array v1, v1, [I

    .line 544
    .local v1, "loBits":[I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    array-length v3, p2

    if-ge v2, v3, :cond_2

    .line 545
    aget-wide v3, p2, v2

    .line 546
    .local v3, "l":J
    const/16 v5, 0x20

    shr-long v5, v3, v5

    long-to-int v5, v5

    aput v5, v0, v2

    .line 547
    long-to-int v5, v3

    aput v5, v1, v2

    .line 544
    .end local v3    # "l":J
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 549
    .end local v2    # "i":I
    :cond_2
    invoke-virtual {p0, p1, v0, p4}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v2

    .line 550
    .local v2, "hi":[B
    invoke-virtual {p0, p1, v1, p3}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v3

    .line 551
    .local v3, "lo":[B
    array-length v4, v2

    array-length v5, v3

    add-int/2addr v4, v5

    new-array v4, v4, [B

    .line 552
    .local v4, "total":[B
    array-length v5, v2

    const/4 v6, 0x0

    invoke-static {v2, v6, v4, v6, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 553
    array-length v5, v2

    add-int/lit8 v5, v5, 0x1

    array-length v7, v3

    invoke-static {v3, v6, v4, v5, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 554
    return-object v4
.end method

.method protected encodeFlags(Ljava/lang/String;[[JLorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[B
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "flags"    # [[J
    .param p3, "loCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "hiCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "haveHiFlags"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 622
    invoke-direct {p0, p2}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->flatten([[J)[J

    move-result-object v2

    move-object v0, p0

    move-object v1, p1

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/pack200/BandSet;->encodeFlags(Ljava/lang/String;[JLorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[B

    move-result-object v0

    return-object v0
.end method

.method public encodeScalar(ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B
    .locals 1
    .param p1, "value"    # I
    .param p2, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 84
    invoke-virtual {p2, p1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode(I)[B

    move-result-object v0

    return-object v0
.end method

.method public encodeScalar([ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B
    .locals 1
    .param p1, "band"    # [I
    .param p2, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 72
    invoke-virtual {p2, p1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode([I)[B

    move-result-object v0

    return-object v0
.end method

.method protected integerListToArray(Ljava/util/List;)[I
    .locals 3
    .param p1, "integerList"    # Ljava/util/List;

    .line 564
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [I

    .line 565
    .local v0, "array":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    .line 566
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aput v2, v0, v1

    .line 565
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 568
    .end local v1    # "i":I
    :cond_0
    return-object v0
.end method

.method protected longListToArray(Ljava/util/List;)[J
    .locals 4
    .param p1, "longList"    # Ljava/util/List;

    .line 578
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [J

    .line 579
    .local v0, "array":[J
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    .line 580
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 579
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 582
    .end local v1    # "i":I
    :cond_0
    return-object v0
.end method

.method public abstract pack(Ljava/io/OutputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation
.end method
