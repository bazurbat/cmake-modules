#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <stdio.h>
#include <stdlib.h>
#include "counter.h"

SM_COUNTER_DECLARE(loop);

void cinc(void)
{
    SM_COUNTER_INC(loop);
}

int main(int argc, char *argv[])
{
    const char *filename = argv[1];

    av_register_all();

    AVFormatContext *format_ctx = NULL;
    if (avformat_open_input (&format_ctx, filename, NULL, NULL) < 0)
    {
        av_log (NULL, AV_LOG_ERROR, "Could not open input file\n");
        return -1;
    }

    av_dump_format (format_ctx, 0, filename, 0);

    if (avformat_find_stream_info (format_ctx, NULL) < 0)
    {
        av_log (NULL, AV_LOG_ERROR, "Could not find stream information\n");
        goto end;
    }

    AVCodec *decoder = NULL;
    int stream_index = av_find_best_stream (format_ctx, AVMEDIA_TYPE_VIDEO,
                                            -1, -1, &decoder, 0);
    if (stream_index < 0)
    {
        av_log (NULL, AV_LOG_ERROR, "Could not find the best stream\n");
        goto end;
    }

    AVCodecContext *codec = format_ctx->streams[stream_index]->codec;
    if (avcodec_open2 (codec, decoder, NULL) < 0)
    {
        av_log (NULL, AV_LOG_ERROR, "Could not open codec\n");
        goto end;
    }

    av_log(NULL, AV_LOG_INFO, "Codec name: %s\n", codec->codec_name);
    av_log(NULL, AV_LOG_INFO, "Codec id: %d\n", codec->codec_id);
    av_log(NULL, AV_LOG_INFO, "Pixel format: %d\n", codec->pix_fmt);

    AVFrame *frame = avcodec_alloc_frame ();
    if (!frame)
    {
        av_log (NULL, AV_LOG_ERROR, "Could not allocate video frame\n");
        goto end;
    }

    AVPacket pkt =
    {
        .data = NULL,
        .size = 0
    };
    av_init_packet(&pkt);

    while (av_read_frame (format_ctx, &pkt) >= 0)
    {
        int64_t pts = pkt.pts;
        int64_t dts = pkt.dts;
        int64_t r = pts - dts;
        // printf("%ld\n", pts - dts);

        av_free_packet (&pkt);

        cinc();
    }

    SM_COUNTER_CLOSE(loop);

end:
    av_free_packet (&pkt);
    avcodec_free_frame(&frame);
    if (codec)
        avcodec_close(codec);
    if (format_ctx)
        avformat_close_input(&format_ctx);

    return 0;
}
